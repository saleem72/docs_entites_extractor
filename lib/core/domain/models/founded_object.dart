//

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class FoundedObjectWithPhoto {
  final String label;
  final double confidence;
  final DetectedObject object;
  final Face face;
  final InputImage inputImage;

  FoundedObjectWithPhoto({
    required this.label,
    required this.confidence,
    required this.object,
    required this.inputImage,
    required this.face,
  });
}

class FoundedObject {
  final String label;
  final double confidence;
  final DetectedObject object;
  final InputImage inputImage;

  FoundedObject({
    required this.label,
    required this.confidence,
    required this.object,
    required this.inputImage,
  });
}

class FoundedObjectWithoutImage {
  final String label;
  final DetectedObject object;
  final double confidence;

  FoundedObjectWithoutImage({
    required this.label,
    required this.object,
    required this.confidence,
  });
}
