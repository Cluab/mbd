import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A utility class for accessing application configuration values, primarily from environment variables.
///
/// This class centralizes the retrieval of sensitive or environment-specific
/// configurations, such as API keys and service URLs. It leverages the `flutter_dotenv`
/// package to load these values from a `.env` file at runtime.
///
/// The `.env` file should be included in your project's `.gitignore` to prevent
/// committing sensitive information to version control.
///
/// Example usage:
/// ```dart
/// String apiUrl = Config.supabaseUrl;
/// String apiKey = Config.supabaseAnonKey;
/// ```
/// Ensure that `await dotenv.load(fileName: ".env");` has been called (e.g., in `main.dart`)
/// before accessing these static getters.
class Config {
  /// Retrieves the Supabase project URL from the loaded environment variables.
  ///
  /// It looks for a variable named `SUPABASE_URL` in the `.env` file.
  /// If the variable is not found or is null, it defaults to an empty string.
  /// In a production scenario, a more robust error handling or default mechanism
  /// might be needed if these values are critical for app functionality.
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  
  /// Retrieves the Supabase anonymous key from the loaded environment variables.
  ///
  /// It looks for a variable named `SUPABASE_ANON_KEY` in the `.env` file.
  /// If the variable is not found or is null, it defaults to an empty string.
  /// Similar to `supabaseUrl`, consider implications of this key not being available.
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
} 