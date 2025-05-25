import 'package:flutter/material.dart';

/// A reusable widget that displays a centered circular progress indicator.
///
/// This widget is typically used to indicate a loading state in the UI,
/// for example, when fetching data from a network or performing a long-running task.
/// It can optionally display a text message below the progress indicator to provide
/// more context to the user (e.g., "Loading data...").
class LoadingIndicator extends StatelessWidget {
  /// An optional message to be displayed below the circular progress indicator.
  /// If null, no message is displayed.
  final String? message;

  /// Creates an instance of [LoadingIndicator].
  ///
  /// The [key] is passed to the superclass.
  /// The [message] parameter is optional and defaults to null.
  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    // Centers its child widgets on the screen.
    return Center(
      // Arranges the progress indicator and optional message vertically.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically within the Column.
        crossAxisAlignment: CrossAxisAlignment.center, // Centers children horizontally within the Column.
        children: [
          // The standard Material Design circular progress indicator.
          const CircularProgressIndicator(),
          // Conditionally add spacing and the message text if a message is provided.
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 20), // Adds vertical spacing between the indicator and the message.
            Text(
              message!, // The message text.
              style: Theme.of(context).textTheme.titleMedium, // Uses a slightly larger style for the message.
              textAlign: TextAlign.center, // Ensures the message text is centered if it wraps.
            ),
          ],
        ],
      ),
    );
  }
} 