//

//Import the Image package
import 'dart:math' as math;
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:docs_entites_extractor/core/data/helpers/coordinates_translator.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'package:image/image.dart' as img_lib;

extension InputImageToUnit8List on InputImage {
  img_lib.Image toImage(Size size) {
    final width = metadata?.size.width.toInt() ?? size.width.toInt();
    final height = metadata?.size.height.toInt() ?? size.height.toInt();

    Uint8List yuv420sp = bytes!;
    //int total = width * height;
    //Uint8List rgb = Uint8List(total);
    var outImg =
        img_lib.Image(width: width, height: height); // default numChannels is 3

    final int frameSize = width * height;

    for (int j = 0, yp = 0; j < height; j++) {
      int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
      for (int i = 0; i < width; i++, yp++) {
        int y = (0xff & yuv420sp[yp]) - 16;
        if (y < 0) y = 0;
        if ((i & 1) == 0) {
          v = (0xff & yuv420sp[uvp++]) - 128;
          u = (0xff & yuv420sp[uvp++]) - 128;
        }
        int y1192 = 1192 * y;
        int r = (y1192 + 1634 * v);
        int g = (y1192 - 833 * v - 400 * u);
        int b = (y1192 + 2066 * u);

        if (r < 0) {
          r = 0;
        } else if (r > 262143) {
          r = 262143;
        }
        if (g < 0) {
          g = 0;
        } else if (g > 262143) {
          g = 262143;
        }
        if (b < 0) {
          b = 0;
        } else if (b > 262143) {
          b = 262143;
        }

        // outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
        //     ((g >> 2) & 0xff00) >> 8, b & 0xff);
        outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
            ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);

        /*rgb[yp] = 0xff000000 |
            ((r << 6) & 0xff0000) |
            ((g >> 2) & 0xff00) |
            ((b >> 10) & 0xff);*/
      }
    }

    //Rotate Image 90 degree to left
    // outImg = img_lib.copyRotate(outImg, angle: 90);
    // final result = img_lib.encodeJpg(outImg);
    return outImg;
  }

  Uint8List toUint8List() {
    img_lib.Image outImg = toImage(const Size(200, 200));

    //Rotate Image 90 degree to left
    outImg = img_lib.copyRotate(outImg, angle: 90);
    final result = img_lib.encodeJpg(outImg);
    return result;
  }

  Uint8List faceFromImage(
    Face face, {
    required Size size,
    int extraHeight = 80,
    int extraWidth = 40,
  }) {
    final image = toImage(size);
    final rect = face.boundingBox;

    final meta = metadata;
    final top = translateX(
      rect.top,
      meta!.size,
      meta.size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    final left = translateY(
      rect.left,
      meta.size,
      meta.size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    final rotatedImage = img_lib.copyRotate(image, angle: 90);

    img_lib.Image croppedFace = img_lib.copyCrop(
      rotatedImage,
      x: math.max(0, (left - extraWidth / 2).toInt()),
      y: math.max(0, (top - extraHeight / 2).toInt()),
      width: rect.width.toInt() + extraWidth,
      height: rect.height.toInt() + extraHeight,
    );

    final result = img_lib.encodeJpg(croppedFace);
    return result;
  }

  Future<Uint8List> idFromObject(
    DetectedObject object, {
    int extraHeight = 80,
    int extraWidth = 40,
  }) async {
    img_lib.Image image = toImage(const Size(200, 200));
    // image = img_lib.bakeOrientation(image);
    final rect = object.boundingBox;

    final meta = metadata;
    final top = translateX(
      rect.top,
      meta!.size,
      meta.size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    final left = translateY(
      rect.left,
      meta.size,
      meta.size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    final rotatedImage = img_lib.copyRotate(image, angle: 90);

    img_lib.Image croppedFace = img_lib.copyCrop(
      rotatedImage,
      x: math.max(0, (left - extraWidth / 2).toInt()),
      y: math.max(0, (top - extraHeight / 2).toInt()),
      width: rect.width.toInt() + extraWidth,
      height: rect.height.toInt() + extraHeight,
    );

    final result = img_lib.encodeJpg(croppedFace);
    return result;
  }

  Uint8List idFromImage() {
    final image = toImage(const Size(200, 200));

    final meta = metadata!;

    final rotatedImage = img_lib.copyRotate(image, angle: 90);

    final width = meta.size.width;
    final height = meta.size.height;
    final clearAreaWidth = width.toInt();
    final clearAreaHeight = (height * 0.8).toInt();

    developer.log('width: $width');
    developer.log('height: $height');
    developer.log('clearAreaWidth: $clearAreaWidth');
    developer.log('clearAreaHeight: $clearAreaHeight');

    img_lib.Image croppedFace = img_lib.copyCrop(
      rotatedImage,
      x: 0,
      y: (height * 0.6).toInt(),
      width: clearAreaWidth,
      height: clearAreaHeight,
    );

    final result = img_lib.encodeJpg(croppedFace);
    return result;
  }
}

extension ImageTools on img_lib.Image {
  Uint8List faceFromImage({
    required Rect boundingBox,
    int extraHeight = 80,
    int extraWidth = 40,
  }) {
    // final rect = face.boundingBox;
    final size = Size(width.toDouble(), height.toDouble());

    final top = translateX(
      boundingBox.top,
      size,
      size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    final left = translateY(
      boundingBox.left,
      size,
      size,
      InputImageRotation.rotation0deg,
      CameraLensDirection.back,
    );

    img_lib.Image croppedFace = img_lib.copyCrop(
      this,
      x: math.max(0, (left - extraWidth / 2).toInt()),
      y: math.max(0, (top - extraHeight / 2).toInt()),
      width: boundingBox.width.toInt() + extraWidth,
      height: boundingBox.height.toInt() + extraHeight,
    );

    final result = img_lib.encodeJpg(croppedFace);
    return result;
  }
}
