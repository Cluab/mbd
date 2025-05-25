import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config.dart';
import 'config/routes.dart';
import 'config/theme.dart';

/// Main entry point of the application.
/// Initializes Supabase and environment variables before running the app.
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Load environment variables from .env file
    await dotenv.load(fileName: ".env");
    
    // Initialize Supabase with credentials from environment variables
    await Supabase.initialize(
      url: Config.supabaseUrl,
      anonKey: Config.supabaseAnonKey,
    );
  } catch (e) {
    print('Error initializing app: $e');
    // You might want to show a user-friendly error message here
  }
  
  runApp(const MyApp());
}

/// Root widget of the application.
/// Sets up the theme and initial screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISN - Islamic Services Network',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Respect system theme settings
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
