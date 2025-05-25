import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config.dart';
import 'config/routes.dart';
import 'config/theme.dart';

/// Asynchronous main function, the primary entry point for the Flutter application.
///
/// This function performs essential initializations before the application UI is run:
/// 1. Ensures that Flutter's widget binding is initialized, which is necessary for
///    calling platform-specific code and using plugins before `runApp()`.
/// 2. Attempts to load environment variables from a `.env` file. These variables
///    typically include sensitive information like API keys or service URLs.
/// 3. Initializes the Supabase client with the URL and anonymous key obtained from
///    the loaded environment variables. Supabase is used for backend services.
/// 4. If any error occurs during initialization (e.g., `.env` file not found,
///    Supabase credentials incorrect), it prints an error message to the console.
///    In a production app, more sophisticated error handling might be implemented.
/// 5. Finally, it runs the main application widget, `MyApp`.
void main() async {
  // Ensures that the Flutter widget binding is initialized. This is crucial
  // for using platform channels or other Flutter-specific features before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables from the .env file.
    // This allows for secure management of Supabase URL and anon key.
    // The `Config.supabaseUrl` and `Config.supabaseAnonKey` will then access these.
    await dotenv.load(fileName: ".env");

    // Initialize the Supabase client.
    // The URL and anon key are fetched from the environment variables via the Config class.
    // This setup allows the app to communicate with your Supabase backend.
    await Supabase.initialize(
      url: Config.supabaseUrl,
      anonKey: Config.supabaseAnonKey,
    );
  } catch (e) {
    // If there's an error during the initialization (e.g., .env not found,
    // Supabase keys are invalid), print it to the console.
    // For a production app, consider more robust error handling like logging
    // to a remote service or showing a user-friendly error screen.
    print('Error initializing app: $e');
    // Optionally, rethrow the error if it's critical and the app cannot run
    // throw Exception('Failed to initialize critical services: $e');
  }

  // Run the root widget of the application.
  runApp(const MyApp());
}

/// The root widget of the ISN (Islamic Services Network) application.
///
/// `MyApp` is a [StatelessWidget] because its configuration doesn't change over time.
/// It sets up the [MaterialApp], which provides core functionalities like theming,
/// navigation, and localization.
class MyApp extends StatelessWidget {
  /// Constructor for the MyApp widget.
  /// The `key` parameter is passed to the superclass for widget identification and state preservation.
  const MyApp({super.key});

  /// Builds the widget tree for the application.
  ///
  /// This method returns a [MaterialApp] configured with:
  /// - `title`: The title of the application, used by the operating system.
  /// - `theme`: The light theme defined in `AppTheme.lightTheme`.
  /// - `darkTheme`: The dark theme defined in `AppTheme.darkTheme`.
  /// - `themeMode`: Set to `ThemeMode.system` to automatically adapt to the
  ///   user's system preference (light or dark mode).
  /// - `onGenerateRoute`: A callback function (`AppRoutes.generateRoute`) that handles
  ///   the generation of named routes for navigation.
  /// - `initialRoute`: The route that is displayed when the application first starts
  ///   (set to `AppRoutes.home`, likely pointing to the categories screen).
  /// - `debugShowCheckedModeBanner`: Set to `false` to hide the "debug" banner
  ///   in the top-right corner of the app during development.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISN - Islamic Services Network',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Respects the user's system light/dark mode preference.
      // `onGenerateRoute` is used for handling named navigation.
      // It delegates route generation to the `AppRoutes.generateRoute` method.
      onGenerateRoute: AppRoutes.generateRoute,
      // `initialRoute` specifies the first screen to be displayed.
      initialRoute: AppRoutes.home, // Typically, this would be the categories or home screen.
      // Hides the debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,
    );
  }
}
