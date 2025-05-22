import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class that provides access to environment variables.
/// This class uses flutter_dotenv to securely access Supabase credentials
/// stored in the .env file.
class Config {
  /// Gets the Supabase project URL from environment variables.
  /// Returns an empty string if the URL is not found.
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  
  /// Gets the Supabase anonymous key from environment variables.
  /// Returns an empty string if the key is not found.
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
} 