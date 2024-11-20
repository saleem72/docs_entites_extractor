//

import 'dart:io' as io;

class AppImageInfo {
  final io.File image;
  final String type;
  final double confidence;
  AppImageInfo({
    required this.image,
    required this.type,
    required this.confidence,
  });
}
