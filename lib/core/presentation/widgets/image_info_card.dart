//

import 'package:docs_entites_extractor/core/domain/models/app_image_info.dart';
import 'package:flutter/material.dart';

class ImageInfoCard extends StatelessWidget {
  const ImageInfoCard({
    super.key,
    required this.info,
  });

  final AppImageInfo info;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Row(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.file(info.image),
          ),
          const SizedBox(width: 16),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  info.type,
                ),
                Text(
                  info.confidence.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
