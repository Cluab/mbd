import 'package:flutter/material.dart';

/// A reusable widget for displaying a user-friendly error message.
///
/// This widget is designed to be shown when an error occurs in the application,
/// for instance, when data fetching fails or an unexpected exception is caught.
/// It displays a prominent error icon, the error message itself, and an optional
/// "Retry" button if a callback for retrying the failed action is provided.
class ErrorDisplay extends StatelessWidget {
  /// The error message to be displayed to the user.
  /// This message should be clear and informative, helping the user understand the issue.
  final String message;

  /// An optional callback function that is invoked when the user taps the "Retry" button.
  /// If this is null, the "Retry" button will not be displayed.
  /// This is typically used to re-attempt the action that led to the error.
  final VoidCallback? onRetry;

  /// Creates an instance of [ErrorDisplay].
  ///
  /// Requires a [message] to display.
  /// The [onRetry] callback is optional.
  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Centers the error content on the screen.
    return Center(
      // Adds padding around the content for better visual spacing.
      child: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding for better aesthetics
        // Arranges the icon, message, and retry button vertically.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically.
          crossAxisAlignment: CrossAxisAlignment.center, // Centers children horizontally.
          children: [
            // Displays a standard error icon.
            Icon(
              Icons.error_outline, // A common icon for indicating errors.
              color: Theme.of(context).colorScheme.error, // Uses the error color from the current theme.
              size: 60, // A larger icon for more prominence.
            ),
            const SizedBox(height: 20), // Spacing between the icon and the message.
            // Displays the error message text.
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error, // Message text also uses the error color.
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center, // Ensures the message is centered if it wraps to multiple lines.
            ),
            // Conditionally display the Retry button if an onRetry callback is provided.
            if (onRetry != null) ...[
              const SizedBox(height: 24), // Spacing between the message and the button.
              ElevatedButton.icon(
                onPressed: onRetry, // Calls the provided onRetry callback when pressed.
                icon: const Icon(Icons.refresh), // Refresh icon for the retry button.
                label: const Text('Try Again'), // Text for the retry button.
                // style: ElevatedButton.styleFrom(...), // Optional: Further style the button if needed.
              ),
            ],
          ],
        ),
      ),
    );
  }
} 