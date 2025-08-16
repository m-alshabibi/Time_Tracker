import 'package:flutter/material.dart';

// --- Semantic Color Definitions ---
// These are the *roles* of our colors.
// Their actual values will change based on light/dark mode.
class AppColor {
  // Core colors
  static const Color primary = Color(0xFF1A237E); // Deep Navy (Light mode)
  static const Color secondary = Color(
    0xFF009688,
  ); // Sophisticated Teal (Light mode)
  static const Color background = Color(0xFFF5F5F5); // Off-white (Light mode)
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFF44336); // Red
  static const Color darkPrimary = Color(0xFF5A6DB8);
  static const Color darkSecondary = Color(0xFF5A6DB8);
  static const Color darkBackground = Color(0xFF191A1F);
  static const Color darkSurface = Color(0xFF1F222B);

  // "On" colors - for text/icons placed *on* the corresponding background color
  static const Color onPrimary = Colors.black;
  static const Color onSecondary = Colors.white;
  static const Color onBackground = Color(0xFF212121); // Dark grey for text
  static const Color onSurface = Color(0xFF212121); // Dark grey for text
  static const Color onError = Colors.white;
  static const Color darkOnPrimary = Colors.white;
  static const Color darkOnSecondary = Colors.white;
  static const Color darkOnBackground = Color(0xFFE0E0E0);
  static const Color darkOnSurface = Color(0xFF5A6DB8);
  static const Color darkOutline = Color(0xFF424242);

  // Other utility colors
  static const Color outline = Color(0xFFBDBDBD); // Grey for borders/dividers
}

class AppColors {
  // الألوان الأساسية
  static const Color background = Color(0xFF191A1F);
  static const Color card = Color(0xFF1F222B);
  static const Color card1 = Color(0xFF22242B);
  static const Color card2 = Color(0xFF2B2E36);
  static const Color card3 = Color(0xFF1D2026);
  static const Color card4 = Color(0xFF252830);
  static const Color card5 = Color(0xFF292B35);
  static const Color primary = Color(0xFF5A6DB8);

  // ألوان مقاربة
  static const Color accent1 = Color(0xFF7785C2);
  static const Color accent2 = Color(0xFF404D77);
  static const Color textNeutral = Color(0xFFB0B3C2);
  static const Color divider = Color(0xFF2A2D36);

  // ألوان مكاسرة (تباين)
  static const Color complementary = Color(0xFFB86F5A);
  static const Color secondaryStrong = Color(0xFFE3A37C);
  static const Color success = Color(0xFF7CC27C);
  static const Color warning = Color(0xFFE7B76F);
}

class MyThemeApp {
  static ThemeData themeApp({bool light = true}) {
    if (light) {
      return buildLightTheme();
    }
    return buildDarkTheme();
  }
}

// --- Light Theme Definition ---
ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    brightness: Brightness.light,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColor.primary,
      onPrimary: AppColor.onPrimary,
      secondary: AppColor.secondary,
      onSecondary: AppColor.onSecondary,
      background: AppColor.background,
      onBackground: AppColor.onBackground,
      surface: AppColor.surface,
      onSurface: AppColor.onSurface,
      error: AppColor.error,
      onError: AppColor.onError,
      outline: AppColor.outline, // Custom property for borders/dividers
    ),
    scaffoldBackgroundColor: AppColor.background,
    cardColor: AppColor.surface,
    dividerColor: AppColor.outline,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.background,
      foregroundColor: AppColor.onPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: AppColor.onPrimary,
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColor.onSecondary, // Text on accent color
        backgroundColor: AppColor.secondary, // Accent color
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.secondary,
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.secondary,
        side: const BorderSide(color: AppColor.secondary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),

    // Input Decoration Theme (for TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.surface,
      labelStyle: TextStyle(color: AppColor.onSurface.withOpacity(0.7)),
      hintStyle: TextStyle(color: AppColor.onSurface.withOpacity(0.5)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.outline, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.secondary, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.error, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.error, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      elevation: 2.0,
      color: AppColor.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),

    // Text Theme (using a base text theme for light mode)
    textTheme: _buildLightTextTheme(base.textTheme),
    primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColor.onSurface),
    primaryIconTheme: IconThemeData(color: AppColor.onPrimary),
  );
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    headlineLarge: base.headlineLarge?.copyWith(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: AppColor.onBackground,
      fontSize: 32.0,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      color: AppColor.onBackground,
      fontSize: 24.0,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: AppColor.onBackground,
      fontSize: 20.0,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.onBackground,
      fontSize: 16.0,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.onBackground,
      fontSize: 14.0,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 14.0,
    ),
  );
}

// --- Dark Theme Definition ---
ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark(); // Start with a dark base theme

  // Slightly desaturated colors for dark mode
  // const Color darkPrimary =
  //     Color(0xFF673AB7); // A slightly lighter, desaturated purple-blue
  const Color darkPrimary = Color(0xFF5A6DB8);
  const Color darkSecondary = Color(
    0xFF5A6DB8,
  ); // A slightly lighter, desaturated teal
  // const Color darkBackground =
  //     Color(0xFF121212); // Very dark grey, almost black
  const Color darkBackground = Color(0xFF191A1F);
  // const Color darkSurface =
  //     Color(0xFF1E1E1E); // Slightly lighter than background for elevation
  const Color darkSurface = Color(0xFF1F222B);
  const Color darkOnPrimary = Colors.white;
  const Color darkOnSecondary = Colors.white;
  const Color darkOnBackground = Color(0xFFE0E0E0);
  const Color darkOnSurface = Color(0xFFE0E0E0);
  const Color darkOutline = Color(0xFF424242);

  return base.copyWith(
    brightness: Brightness.dark,

    colorScheme: base.colorScheme.copyWith(
      primary: darkPrimary,
      onPrimary: darkOnPrimary,
      secondary: darkSecondary,
      onSecondary: darkOnSecondary,
      background: darkBackground,
      onBackground: darkOnBackground,
      surface: darkSurface,
      onSurface: darkOnSurface,
      error: AppColor.error, // Error color can often remain consistent
      onError: AppColor.onError,
      outline: darkOutline,
    ),
    scaffoldBackgroundColor: darkBackground,
    cardColor: AppColors.card,
    dividerColor: darkOutline,

    // AppBar Theme (adapted for dark mode)
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkOnPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: darkOnPrimary,
      ),
    ),

    // Button Themes (adapted for dark mode)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: darkOnSecondary,
        backgroundColor: darkSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkSecondary,
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkSecondary,
        side: const BorderSide(color: darkSecondary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ),

    // Input Decoration Theme (adapted for dark mode)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      labelStyle: TextStyle(color: darkOnSurface.withOpacity(0.7)),
      hintStyle: TextStyle(color: darkOnSurface.withOpacity(0.5)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkOutline, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkSecondary, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.error, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.error, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
    ),

    // Card Theme (adapted for dark mode)
    cardTheme: CardThemeData(
      elevation: 2.0,
      color: darkSurface, // Card background uses dark surface
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),

    // Text Theme (using a base text theme for dark mode)
    textTheme: _buildDarkTextTheme(base.textTheme),
    primaryTextTheme: _buildDarkTextTheme(base.primaryTextTheme),

    // Icon Theme (adapted for dark mode)
    iconTheme: IconThemeData(color: darkOnSurface),
    primaryIconTheme: IconThemeData(color: darkOnPrimary),
  );
}

TextTheme _buildDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headlineLarge: base.headlineLarge?.copyWith(
      fontFamily: 'regular',
      fontWeight: FontWeight.bold,
      color: AppColor.darkOnBackground,
      fontSize: 32.0,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontFamily: 'regular',
      fontWeight: FontWeight.w600,
      color: AppColor.darkOnBackground,
      fontSize: 24.0,
    ),
    headlineSmall: base.headlineMedium?.copyWith(
      fontFamily: 'regular',
      fontWeight: FontWeight.w600,
      color: AppColor.darkOnBackground,
      fontSize: 20.0,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: AppColor.darkOnPrimary,
      fontSize: 18.0,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: AppColor.darkOnPrimary,
      fontSize: 16.0,
    ),
    titleSmall: base.titleLarge?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.darkOnBackground,
      fontSize: 14.0,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.darkOnPrimary,
      fontSize: 16.0,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.darkOnPrimary,
      fontSize: 14.0,
    ),
    bodySmall: base.bodySmall?.copyWith(
      fontFamily: 'Roboto',
      color: AppColor.darkSecondary,
      fontSize: 12.0,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      fontSize: 14.0,
    ),
    labelMedium: base.labelMedium?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Color(0xff5E606C),
      fontSize: 12.0,
    ),
    labelSmall: base.labelMedium?.copyWith(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Color(0xff5E606C),
      fontSize: 10.0,
    ),
  );
}
