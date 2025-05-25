import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';

/// Route configuration for the ISN app.
/// Defines all available routes and their builders.
class AppRoutes {
  /// Named routes for the application
  static const String categories = '/categories';
  static const String home = '/';

  /// Route generator for the application.
  /// Maps route names to their respective screen builders.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case categories:
      case home:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 