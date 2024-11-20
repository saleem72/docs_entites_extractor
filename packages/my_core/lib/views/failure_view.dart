//

import 'package:flutter/material.dart';

import '../errors/failure.dart';
import './../extensions/build_context_extension.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    super.key,
    required this.failure,
    this.title = 'Error',
    this.buttonLabel = 'Ok',
    required this.onClose,
    this.buttonAlignment = MainAxisAlignment.center,
  });
  final Failure? failure;
  final String title;
  final String buttonLabel;
  final Function() onClose;
  final MainAxisAlignment buttonAlignment;
  @override
  Widget build(BuildContext context) {
    return failure == null
        ? const SizedBox.shrink()
        : Container(
            color: Colors.black26,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(32),
                    // margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          failure?.message ?? '',
                          style: context.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: buttonAlignment,
                          children: [
                            FilledButton(
                                onPressed: onClose,
                                child: Text(
                                  buttonLabel,
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
