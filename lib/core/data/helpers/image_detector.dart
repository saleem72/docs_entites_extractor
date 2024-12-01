//

import 'dart:developer' as developer;
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:docs_entites_extractor/core/configuration/ml/ml_models.dart';
import 'package:docs_entites_extractor/core/domain/models/app_image_info.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'package:docs_entites_extractor/core/data/extensions/input_image_extension.dart';
import 'package:docs_entites_extractor/core/data/helpers/utils.dart';

class ImageDetector {
  ImageDetector() {
    _initializeDetector();
  }
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  ObjectDetector? _objectDetector;
  // test
  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;
    final modelPath = await getAssetPath(MLModels.efficientNetFloat32);
    final options = LocalObjectDetectorOptions(
      mode: DetectionMode.single,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);
    if (_objectDetector != null) {
      developer.log('_objectDetector was initialized 😍😍');
    } else {
      developer.log('_objectDetector was not initialized 😒😒');
    }
  }

  // Uint8List bytes, InputImageMetadata metadata
  Future<io.File?> searchForPhoto(io.File file) async {
    final temp = img.decodeImage(file.readAsBytesSync());
    final image = InputImage.fromFile(file);

    final faces = await _faceDetector.processImage(image);

    if (faces.isEmpty) {
      return null;
    }

    final face = faces.first;
    final bytes = temp!.faceFromImage(boundingBox: face.boundingBox);
    final photo = fileFromUint8List(bytes);
    return photo;
  }

  Future<List<AppImageInfo>> searchForObjects(io.File file) async {
    if (_objectDetector == null) {
      developer.log('_objectDetector not initialized');
      return [];
    }
    final inputImage = InputImage.fromFile(file);
    final objects = await _objectDetector!.processImage(inputImage);
    if (objects.isEmpty) {
      return [];
    }
    final image = img.decodeImage(file.readAsBytesSync());
    if (image == null) {
      developer.log('Couldn\'t create image');
      return [];
    }
    final futures = <Future>[];
    final names = <String>[];
    final confidences = <double>[];
    for (final object in objects) {
      final bytes = image.faceFromImage(boundingBox: object.boundingBox);
      final photo = fileFromUint8List(bytes);
      final name = object.labels.firstOrNull?.text ?? 'no name';
      final confidence = object.labels.firstOrNull?.confidence ?? 0;
      names.add(name);
      confidences.add(confidence);

      futures.add(photo);
    }
    // <>
    final filesList = await Future.wait(futures);
    final photos = <io.File>[];
    for (final photo in filesList) {
      if (photo is io.File) {
        photos.add(photo);
      }
    }
    final infos = <AppImageInfo>[];

    for (int i = 0; i < photos.length; i++) {
      final info = AppImageInfo(
        image: photos[i],
        type: names[i],
        confidence: confidences[i],
      );
      infos.add(info);
    }
    return infos;
  }

  Future<io.File> fileFromUint8List(Uint8List imageInUnit8List) async {
    final tempDir = await getTemporaryDirectory();
    io.File file =
        await io.File('${tempDir.path}/${DateTime.now().toString()}.png')
            .create();
    file.writeAsBytesSync(imageInUnit8List);
    return file;
  }

  cleanTemp() async {
    final tempDir = await getTemporaryDirectory();
    tempDir.deleteSync(recursive: true);
  }

  void dispose() {
    _faceDetector.close();
    _objectDetector?.close();
  }
}
