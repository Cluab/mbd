import 'package:flutter/material.dart';
import '../screens/categories_screen.dart'; // Screen for displaying business categories.
import '../screens/business_list_screen.dart'; // Screen for displaying the list of businesses.
import '../screens/business_detail_screen.dart'; // Screen for displaying individual business details.
import '../screens/map_screen.dart'; // Screen for displaying the map.

/// Manages the routing configuration for the ISN (Islamic Services Network) application.
///
/// This class defines:-
/// 1. Static constants for named routes, making it easy to reference routes throughout the app
///    without using raw strings (e.g., `AppRoutes.categories`).
/// 2. A static method `generateRoute` which is used by `MaterialApp`'s `onGenerateRoute`
///    parameter to handle navigation to named routes.
///
/// Using named routes improves code readability and maintainability, and it centralizes
/// navigation logic.
class AppRoutes {
  /// Named route for the categories screen.
  static const String categories = '/categories';

  /// Named route for the business list screen.
  static const String businessList = '/businesses';

  /// Named route for the business detail screen.
  // Requires a business ID as an argument.
  static const String businessDetail = '/businesses/detail';

  /// Named route for the map screen.
  static const String businessMap = '/map';

  /// Named route for the home screen (or initial screen).
  /// In this application, it currently directs to the BusinessListScreen.
  static const String home = '/'; // Standard convention for the initial/home route.

  /// Generates a route based on the provided [RouteSettings].
  ///
  /// This function is typically passed to the `onGenerateRoute` callback of the [MaterialApp].
  /// It uses a switch statement to determine which screen to display based on the `settings.name`.
  ///
  /// - If the route name matches `AppRoutes.categories` or `AppRoutes.home`,
  ///   it returns a [MaterialPageRoute] that builds the [CategoriesScreen].
  /// - If the route name matches `AppRoutes.businessList` or `AppRoutes.home`,
  ///   it returns a [MaterialPageRoute] that builds the [BusinessListScreen].
  /// - If the route name matches `AppRoutes.businessDetail`, it expects an integer business ID
  ///   as an argument and returns a [MaterialPageRoute] that builds the [BusinessDetailScreen].
  /// - If the route name matches `AppRoutes.businessMap`, it returns a [MaterialPageRoute] that
  ///   builds the [MapScreen].
  /// - For any undefined routes, it returns a [MaterialPageRoute] that displays a
  ///   simple error message indicating that the route was not found.
  ///
  /// The `settings` argument (which includes `name` and `arguments`) is passed along
  /// to the `MaterialPageRoute` so that the target screen can access them if needed.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Switch on the name of the route provided in `settings`.
    switch (settings.name) {
      case categories: // If the route is for categories
        // Return a MaterialPageRoute, which provides a standard screen transition.
        return MaterialPageRoute(
          // The builder function creates the widget for the screen.
          builder: (_) => const CategoriesScreen(),
          // Pass along the original RouteSettings, which can be useful for analytics
          // or accessing arguments on the CategoriesScreen itself if needed later.
          settings: settings,
        );

      case businessList: // If the route is for the business list
      case home:       // If it's the home route (currently the business list)
        // Return a MaterialPageRoute, which provides a standard screen transition.
        return MaterialPageRoute(
          // The builder function creates the widget for the screen.
          builder: (_) => const BusinessListScreen(),
          // Pass along the original RouteSettings, which can be useful for analytics
          // or accessing arguments on the BusinessListScreen itself if needed later.
          settings: settings,
        );

      case businessDetail: // If the route is for business details
        // Expects an integer business ID as an argument.
        if (settings.arguments is int) {
          final businessId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => BusinessDetailScreen(businessId: businessId),
            settings: settings,
          );
        }
        // Handle case where no valid ID is provided.
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Invalid business ID provided.'),
            ),
          ),
          settings: settings, // Pass settings for debugging
        );

      case businessMap: // If the route is for the map screen
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
          settings: settings,
        );

      default: // If no matching route is found
        // Return a MaterialPageRoute that displays a fallback UI indicating an error.
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings, // Still pass settings for completeness
        );
    }
  }
} 