import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalThemeData {
  //Brand Colors
  static const Color primaryPurple = Color(0xFF4D2161);
  static const Color primaryGreen = Color(0xFF299834);
  static const Color lightPurple = Color(0xFF8A4CA3);
  static const Color lightGreen = Color(0xFF4CC75A);
  static const Color darkGray = Color(0xFF333333);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor, TextTheme textTheme) {
    return ThemeData(
        colorScheme: colorScheme,
        fontFamily: 'Roboto',
        focusColor: focusColor,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        textTheme: textTheme,
        highlightColor: Colors.transparent);
  }




  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor,textTheme);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor,textTheme);

  static final textTheme = TextTheme(
    bodySmall: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),
    bodyMedium: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
    bodyLarge: GoogleFonts.roboto(fontSize: 21,fontWeight: FontWeight.w700,color: Colors.black)


  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryPurple,
    onPrimary: white,
    secondary: primaryGreen,
    onSecondary: white,
    error: Colors.redAccent,
    onError: white,
    surface: white,
    onSurface: darkGray,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: lightPurple,
    onPrimary: white,
    secondary: lightGreen,
    onSecondary: darkGray,
    error: Colors.redAccent,
    onError: white,
    surface: Color(0xFF4A4A4A),
    onSurface: white,
    brightness: Brightness.dark,
  );
}
