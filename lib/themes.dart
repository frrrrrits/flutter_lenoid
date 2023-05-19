import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightCustomColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff166e0d),
);

var lightCustomTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightCustomColorScheme,
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(
        color: lightCustomColorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  textTheme: GoogleFonts.ptSansTextTheme(ThemeData.light().textTheme),
);

var darkCustomColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff84db6f),
  brightness: Brightness.dark,
);

var darkCustomTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkCustomColorScheme,
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(
        color: darkCustomColorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  textTheme: GoogleFonts.ptSansTextTheme(ThemeData.dark().textTheme),
);
