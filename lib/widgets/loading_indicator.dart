import 'package:flutter/material.dart';

/// A reusable loading indicator widget that shows a centered progress indicator
/// with an optional message.
class LoadingIndicator extends StatelessWidget {
  /// Optional message to display below the loading indicator
  final String? message;

  /// Creates a loading indicator with an optional message
  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
} 