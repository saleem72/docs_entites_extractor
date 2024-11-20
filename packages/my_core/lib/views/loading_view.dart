//

import 'package:flutter/material.dart';
import './../extensions/build_context_extension.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    required this.isLoading,
    this.label = 'Loading',
    this.showLabel = true,
  });
  final bool isLoading;
  final String label;
  final bool showLabel;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.black26,
            child: Center(
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      showLabel
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  label,
                                  style: context.textTheme.titleMedium,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
