import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF8E85FF);
  static const Color primaryDark = Color(0xFF4A42D6);
  
  // Secondary colors
  static const Color secondary = Color(0xFFFF6584);
  static const Color secondaryLight = Color(0xFFFF8FA3);
  static const Color secondaryDark = Color(0xFFE64C7E);
  
  // Background colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFF8F9FC);
  static const Color surfaceVariant = Color(0xFFF0F4F8);
  static const Color error = Color(0xFFF44336);
  
  // Text colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1E1E2C);
  static const Color onSurface = Color(0xFF1E1E2C);
  static const Color onError = Color(0xFFFFFFFF);
  
  // Other colors
  static const Color border = Color(0xFFD1D9E6);
  static const Color borderLight = Color(0xFFE8EDF5);
  static const Color disabled = Color(0xFFCBD5E0);
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFED8936);
  static const Color info = Color(0xFF4299E1);
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E2C);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkBorder = Color(0xFF2D3748);
}

class AppTextStyles {
  // Display text styles
  static TextStyle displayLarge(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
        letterSpacing: -1.5,
      );
      
  static TextStyle displayMedium(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
        letterSpacing: -0.5,
      );
      
  static TextStyle displaySmall(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
      );
  
  // Headline text styles
  static TextStyle headlineLarge(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
        letterSpacing: 0.25,
      );
      
  static TextStyle headlineMedium(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
      );
      
  static TextStyle headlineSmall(BuildContext context, {bool isDark = false}) => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnBackground : AppColors.onBackground,
      );
  
  // Title text styles
  static TextStyle titleLarge(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
        letterSpacing: 0.15,
      );
      
  static TextStyle titleMedium(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
        letterSpacing: 0.15,
      );
      
  static TextStyle titleSmall(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8),
        letterSpacing: 0.1,
      );
  
  // Body text styles
  static TextStyle bodyLarge(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8),
        letterSpacing: 0.5,
      );
      
  static TextStyle bodyMedium(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8),
        letterSpacing: 0.25,
      );
      
  static TextStyle bodySmall(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white60 : AppColors.onSurface.withOpacity(0.6),
        letterSpacing: 0.4,
      );
  
  // Button text styles
  static TextStyle buttonLarge(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary,
        letterSpacing: 0.5,
      );
      
  static TextStyle buttonMedium(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary,
        letterSpacing: 0.4,
      );
      
  static TextStyle buttonSmall(BuildContext context, {bool isDark = false}) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary,
        letterSpacing: 0.4,
      );
}

class AppTheme {
  // Light theme with dynamic accent color
  static ThemeData lightTheme(Color accent) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: accent,
        primaryContainer: accent.withOpacity(0.3),
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onError: AppColors.onError,
        brightness: Brightness.light,
      ),
      textTheme: _commonTextTheme(isDark: false),
      appBarTheme: _appBarTheme(isDark: false),
      cardTheme: _cardTheme(isDark: false),
      elevatedButtonTheme: _elevatedButtonTheme(false),
      outlinedButtonTheme: _outlinedButtonTheme(false),
      textButtonTheme: _textButtonTheme(false),
      inputDecorationTheme: _inputDecorationTheme(false),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 1),
    );
  }

  // Dark theme with dynamic accent color
  static ThemeData darkTheme(Color accent) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: accent.withOpacity(0.8),
        primaryContainer: accent.withOpacity(0.5),
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondaryDark,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.darkOnSurface,
        onError: AppColors.onError,
        brightness: Brightness.dark,
      ),
      textTheme: _commonTextTheme(isDark: true),
      appBarTheme: _appBarTheme(isDark: true),
      cardTheme: _cardTheme(isDark: true),
      elevatedButtonTheme: _elevatedButtonTheme(true),
      outlinedButtonTheme: _outlinedButtonTheme(true),
      textButtonTheme: _textButtonTheme(true),
      inputDecorationTheme: _inputDecorationTheme(true),
      dividerTheme: const DividerThemeData(color: AppColors.darkBorder, thickness: 1, space: 1),
    );
  }

  // Shared theme components
  static TextTheme _commonTextTheme({required bool isDark}) => TextTheme(
        displayLarge: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground, letterSpacing: -1.5),
        displayMedium: GoogleFonts.poppins(fontSize: 45, fontWeight: FontWeight.bold, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground, letterSpacing: -0.5),
        displaySmall: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground),
        headlineLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground, letterSpacing: 0.25),
        headlineMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground),
        headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnBackground : AppColors.onBackground),
        titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnSurface : AppColors.onSurface, letterSpacing: 0.15),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnSurface : AppColors.onSurface, letterSpacing: 0.15),
        titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8), letterSpacing: 0.1),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8), letterSpacing: 0.5),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: isDark ? Colors.white70 : AppColors.onSurface.withOpacity(0.8), letterSpacing: 0.25),
        bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal, color: isDark ? Colors.white60 : AppColors.onSurface.withOpacity(0.6), letterSpacing: 0.4),
        labelLarge: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary, letterSpacing: 0.5),
        labelMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary, letterSpacing: 0.4),
        labelSmall: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? AppColors.darkOnPrimary : AppColors.onPrimary, letterSpacing: 0.4),
      );

  static AppBarTheme _appBarTheme({required bool isDark}) => AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppColors.onBackground),
        iconTheme: IconThemeData(color: isDark ? Colors.white : AppColors.onBackground),
      );

  static CardTheme _cardTheme({required bool isDark}) => CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5)),
        color: isDark ? AppColors.darkSurface : AppColors.surface,
      );

  static ElevatedButtonThemeData _elevatedButtonTheme(bool isDark) => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(bool isDark) => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          side: BorderSide(color: isDark ? AppColors.primaryLight : AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static TextButtonThemeData _textButtonTheme(bool isDark) => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? AppColors.primaryLight : AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(bool isDark) => InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.primaryLight : AppColors.primary, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.error)),
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      );
}
