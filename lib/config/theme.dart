import 'package:flutter/material.dart';

class AppColors {
  // Friendly & Intuitive Color Palette
  static const Color primary = Color(0xFF5B6AF0); // Calm, trustworthy blue
  static const Color primaryLight = Color(0xFF7B8AF0);
  static const Color primaryDark = Color(0xFF4A5AD0);
  static const Color secondary = Color(0xFFFF9F45); // Warm, friendly orange
  static const Color secondaryLight = Color(0xFFFFB366);
  static const Color secondaryDark = Color(0xFFE68A3D);
  static const Color accent = Color(0xFFE3F2FD); // Light blue accent
  static const Color accentLight = Color(0xFFF1F8FF);
  static const Color accentDark = Color(0xFFBBDEFB);

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Standard positive green
  static const Color successLight = Color(0xFF81C784);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color error = Color(0xFFF44336); // Clear alert red
  static const Color errorLight = Color(0xFFE57373);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);

  // Neutral Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);

  // Light theme colors
  static const Color lightBackground =
      Color(0xFFF8F9FA); // Very light warm gray
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white for cards
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground =
      Color(0xFF212121); // Dark gray, not black
  static const Color lightOnSurface = Color(0xFF212121); // Dark gray, not black
  static const Color lightOnSurfaceVariant = Color(0xFF757575); // Medium gray

  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOnSecondary = Color(0xFFFFFFFF);
  static const Color darkOnBackground = Color(0xFFE0E0E0);
  static const Color darkOnSurface = Color(0xFFE0E0E0);
  static const Color darkOnSurfaceVariant = Color(0xFFBDBDBD);
  static const Color darkBorder = Color(0xFF424242);
  static const Color darkOverlay = Color(0xB3000000);
}

class AppTheme {
  // Typography Scale
  static const double _fontSizeDisplayLarge = 57;
  static const double _fontSizeDisplayMedium = 45;
  static const double _fontSizeDisplaySmall = 36;
  static const double _fontSizeHeadlineLarge = 32;
  static const double _fontSizeHeadlineMedium = 28;
  static const double _fontSizeHeadlineSmall = 24;
  static const double _fontSizeTitleLarge = 22;
  static const double _fontSizeTitleMedium = 16;
  static const double _fontSizeTitleSmall = 14;
  static const double _fontSizeBodyLarge = 16;
  static const double _fontSizeBodyMedium = 14;
  static const double _fontSizeBodySmall = 12;
  static const double _fontSizeLabelLarge = 14;
  static const double _fontSizeLabelMedium = 12;
  static const double _fontSizeLabelSmall = 11;

  // Spacing Scale
  static const double _spacing4 = 4;
  static const double _spacing8 = 8;
  static const double _spacing12 = 12;
  static const double _spacing16 = 16;
  static const double _spacing20 = 20;
  static const double _spacing24 = 24;
  static const double _spacing32 = 32;
  static const double _spacing40 = 40;
  static const double _spacing48 = 48;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.accent,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.accentLight,
        tertiary: AppColors.info,
        tertiaryContainer: AppColors.infoLight,
        surface: AppColors.lightSurface,
        surfaceContainerHighest: AppColors.lightSurfaceVariant,
        error: AppColors.error,
        onPrimary: AppColors.lightOnPrimary,
        onSecondary: AppColors.lightOnSecondary,
        onSurface: AppColors.lightOnSurface,
        onSurfaceVariant: AppColors.lightOnSurfaceVariant,
        onError: AppColors.lightOnPrimary,
        outline: AppColors.border,
        outlineVariant: AppColors.lightSurfaceVariant,
        background: AppColors.lightBackground,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: _fontSizeDisplayLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: _fontSizeDisplayMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          fontSize: _fontSizeDisplaySmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: TextStyle(
          fontSize: _fontSizeHeadlineLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: _fontSizeHeadlineMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          fontSize: _fontSizeHeadlineSmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: TextStyle(
          fontSize: _fontSizeTitleLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: _fontSizeTitleMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: _fontSizeTitleSmall,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: TextStyle(
          fontSize: _fontSizeBodyLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: _fontSizeBodyMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          fontSize: _fontSizeBodySmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: TextStyle(
          fontSize: _fontSizeLabelLarge,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: _fontSizeLabelMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: _fontSizeLabelSmall,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightOnSurface,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 1,
        titleTextStyle: TextStyle(
          fontSize: _fontSizeTitleLarge,
          fontWeight: FontWeight.w500,
          color: AppColors.lightOnSurface,
        ),
        surfaceTintColor: AppColors.lightSurface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 1,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: _spacing16, vertical: _spacing8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightOnPrimary,
          elevation: 1,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: _spacing16, vertical: _spacing16),
        labelStyle: const TextStyle(
          color: AppColors.lightOnSurfaceVariant,
          fontSize: _fontSizeBodyMedium,
        ),
        hintStyle: const TextStyle(
          color: AppColors.lightOnSurfaceVariant,
          fontSize: _fontSizeBodyMedium,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightOnSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: _fontSizeLabelSmall),
        unselectedLabelStyle: TextStyle(fontSize: _fontSizeLabelSmall),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: AppColors.lightSurface,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lightOnPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceVariant,
        selectedColor: AppColors.accent,
        disabledColor: AppColors.lightSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: _fontSizeLabelMedium,
          color: AppColors.lightOnSurfaceVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: _spacing12, vertical: _spacing8),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.infoLight,
        tertiaryContainer: AppColors.info,
        surface: AppColors.darkSurface,
        surfaceContainerHighest: AppColors.darkSurfaceVariant,
        error: AppColors.errorLight,
        onPrimary: AppColors.darkOnPrimary,
        onSecondary: AppColors.darkOnSecondary,
        onSurface: AppColors.darkOnSurface,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
        onError: AppColors.darkOnPrimary,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkSurfaceVariant,
        background: AppColors.darkBackground,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: _fontSizeDisplayLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: _fontSizeDisplayMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          fontSize: _fontSizeDisplaySmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: TextStyle(
          fontSize: _fontSizeHeadlineLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: _fontSizeHeadlineMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          fontSize: _fontSizeHeadlineSmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: TextStyle(
          fontSize: _fontSizeTitleLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: _fontSizeTitleMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: _fontSizeTitleSmall,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: TextStyle(
          fontSize: _fontSizeBodyLarge,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: _fontSizeBodyMedium,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          fontSize: _fontSizeBodySmall,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: TextStyle(
          fontSize: _fontSizeLabelLarge,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: _fontSizeLabelMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: _fontSizeLabelSmall,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkOnSurface,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 1,
        titleTextStyle: TextStyle(
          fontSize: _fontSizeTitleLarge,
          fontWeight: FontWeight.w500,
          color: AppColors.darkOnSurface,
        ),
        surfaceTintColor: AppColors.darkSurface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 1,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: _spacing16, vertical: _spacing8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.darkOnPrimary,
          elevation: 1,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: _spacing24, vertical: _spacing12),
          textStyle: const TextStyle(
            fontSize: _fontSizeLabelLarge,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(88, 48),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: _spacing16, vertical: _spacing16),
        labelStyle: const TextStyle(
          color: AppColors.darkOnSurfaceVariant,
          fontSize: _fontSizeBodyMedium,
        ),
        hintStyle: const TextStyle(
          color: AppColors.darkOnSurfaceVariant,
          fontSize: _fontSizeBodyMedium,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.darkOnSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: _fontSizeLabelSmall),
        unselectedLabelStyle: TextStyle(fontSize: _fontSizeLabelSmall),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: AppColors.darkSurface,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.darkOnPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        selectedColor: AppColors.primaryDark,
        disabledColor: AppColors.darkSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: _fontSizeLabelMedium,
          color: AppColors.darkOnSurfaceVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: _spacing12, vertical: _spacing8),
      ),
    );
  }
}
