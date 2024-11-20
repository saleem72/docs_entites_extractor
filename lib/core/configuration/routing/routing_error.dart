//

import 'package:flutter/material.dart';

class RoutingError extends StatelessWidget {
  final String errorMessage;
  const RoutingError({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
