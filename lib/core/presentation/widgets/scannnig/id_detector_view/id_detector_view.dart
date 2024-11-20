import 'package:camera/camera.dart';
import 'package:docs_entites_extractor/core/configuration/ml/ml_models.dart';
import 'package:docs_entites_extractor/core/configuration/routing/app_screens.dart';
import 'package:docs_entites_extractor/core/data/helpers/utils.dart';
import 'package:docs_entites_extractor/core/domain/models/founded_object.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:my_core/my_core.dart';

import '../detector_view.dart';
import '../painters/face_detector_painter.dart';

class IDDetectorView extends StatefulWidget {
  const IDDetectorView({super.key});

  @override
  State<IDDetectorView> createState() => _IDDetectorViewState();
}

class _IDDetectorViewState extends State<IDDetectorView> {
  ObjectDetector? _objectDetector;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _facesCustomPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    _objectDetector?.close();
    super.dispose();
  }

  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;
    // object_localizer not working  from net
    final modelPath = await getAssetPath(MLModels.objectLabeler);
    final options = LocalObjectDetectorOptions(
      mode: DetectionMode.stream,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseObjectDetectorModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options = FirebaseObjectDetectorOptions(
    //   mode: _mode,
    //   modelName: modelName,
    //   classifyObjects: true,
    //   multipleObjects: true,
    // );
    // _objectDetector = ObjectDetector(options: options);

    _canProcess = true;
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _facesCustomPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraFeedReady: _initializeDetector,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_objectDetector == null) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    final objects = await _objectDetector!.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _facesCustomPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _facesCustomPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
      if (faces.isNotEmpty) {
        final objectWithoutImage = _handleObjects(objects);
        if (objectWithoutImage != null) {
          final FoundedObjectWithPhoto object = FoundedObjectWithPhoto(
            label: objectWithoutImage.label,
            confidence: objectWithoutImage.confidence,
            object: objectWithoutImage.object,
            inputImage: inputImage,
            face: faces.first,
          );
          context.navigator.pushReplacementNamed(
            AppScreens.idResult,
            arguments: object,
          );
        }
      }
    }
  }

  FoundedObjectWithoutImage? _handleObjects(List<DetectedObject> objects) {
    final targets = ['Business card', "Driver's license", 'Passport'];

    for (final DetectedObject detectedObject in objects) {
      if (detectedObject.labels.isNotEmpty) {
        final label = detectedObject.labels
            .reduce((a, b) => a.confidence > b.confidence ? a : b);
        final text = label.text;
        final confidence = label.confidence;
        if (confidence < 0.5) {
          continue;
        }
        if (targets.contains(text)) {
          final FoundedObjectWithoutImage target = FoundedObjectWithoutImage(
            object: detectedObject,
            label: text,
            confidence: label.confidence,
          );
          return target;
        }
      }
    }

    return null;
  }
}
