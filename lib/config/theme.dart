import 'package:flutter/material.dart';

/// Centralized theme configuration for the ISN (Islamic Services Network) application.
///
/// This class defines the light and dark themes for the application, ensuring a
/// consistent look and feel across all screens. It utilizes Material 3 features
/// and provides specific customizations for common widgets like [AppBar], [Card],
/// and [ListTile].
class AppTheme {
  // Private constructor to prevent instantiation of this utility class.
  AppTheme._();

  /// Defines the light theme for the application.
  ///
  /// Key features of the light theme:
  /// - `useMaterial3`: Enables Material 3 design, offering modern UI components and styles.
  /// - `colorScheme`: Generated from a `seedColor` (Islamic green - `0xFF2E7D32`).
  ///   `ColorScheme.fromSeed` automatically derives a full palette of harmonious colors
  ///   for various UI elements (primary, secondary, surface, error, etc.) suitable for light mode.
  /// - `appBarTheme`: Customizes [AppBar] widgets to have centered titles and no elevation by default.
  /// - `cardTheme`: Styles [Card] widgets with a slight elevation and rounded corners for a modern look.
  /// - `listTileTheme`: Adjusts padding for [ListTile] widgets for consistent spacing.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Opt-in to Material 3 design features.
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32), // A deep green often associated with Islamic art/culture.
        brightness: Brightness.light,      // Specifies that this is a light theme.
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true, // Centers the title in AppBars globally.
        elevation: 0,      // Removes the default shadow from AppBars.
        // Consider adding backgroundColor or foregroundColor if a specific AppBar style is desired.
      ),
      cardTheme: CardTheme(
        elevation: 2, // Adds a subtle shadow to cards.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Gives cards rounded corners.
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Optional: add default margins for cards
      ),
      listTileTheme: const ListTileThemeData(
        // Default padding for ListTiles to ensure consistent spacing.
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // selectedTileColor: Colors.green.shade100, // Optional: Style for selected ListTiles
      ),
      // Add other component themes or properties as needed, e.g.:
      // textTheme: ..., 
      // elevatedButtonTheme: ..., 
      // inputDecorationTheme: ...
    );
  }

  /// Defines the dark theme for the application.
  ///
  /// Key features of the dark theme:
  /// - `useMaterial3`: Enables Material 3 design.
  /// - `colorScheme`: Generated from the same `seedColor` (Islamic green - `0xFF2E7D32`)
  ///   but with `brightness: Brightness.dark`. `ColorScheme.fromSeed` will derive a
  ///   dark-mode appropriate palette from this seed.
  /// - `appBarTheme`, `cardTheme`, `listTileTheme`: Similar customizations as the light theme,
  ///   ensuring consistency in component styling but adapted for a dark background.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, // Opt-in to Material 3 design features.
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32), // Same seed color, palette adapted for dark mode.
        brightness: Brightness.dark,       // Specifies that this is a dark theme.
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        // Consider different background/foreground for dark mode if needed.
      ),
      cardTheme: CardTheme(
        elevation: 2, // Shadow might appear different on dark backgrounds; adjust if needed.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // color: Colors.grey[800], // Optional: Explicit card color for dark theme
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // selectedTileColor: Colors.green.shade700, // Optional: Style for selected ListTiles in dark mode
      ),
      // Add other component themes or properties as needed.
    );
  }
} 