//

import 'package:docs_entites_extractor/core/domain/models/founded_object.dart';
import 'package:flutter/material.dart';

class IDDetectorResultScreen extends StatelessWidget {
  const IDDetectorResultScreen({
    super.key,
    required this.object,
  });
  final FoundedObjectWithPhoto object;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID detector result'),
      ),
    );
  }
}
