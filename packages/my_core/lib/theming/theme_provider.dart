//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_scheme_provider.dart';
import 'pallet.dart';
import 'text_theme_provider.dart';

class ThemeProvider {
  ThemeProvider._internal();

  static void setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? Pallet.neutral.shade700
          : Pallet.neutral.shade300,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  static ThemeData lightTheme() {
    final colorScheme = ColorSchemeProvider.lightFromCorePalette;
    final textTheme = TextThemeProvider.generate(Brightness.light);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textStyle: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          // minimumSize: const Size.fromHeight(46),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.primaryContainer.withOpacity(0.5);
              }
              return colorScheme.primaryContainer;
            },
          ),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          textStyle: WidgetStateProperty.resolveWith(
              (states) => textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  )),
        ),
      ),
    );
  }

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorSchemeProvider.darkFromCorePalette,
    textTheme: TextThemeProvider.generate(Brightness.dark),
    // canvasColor: Pallet.neutral.shade700,
    // fontFamily: 'Poppins',
    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 4,
      backgroundColor: Colors.white,
    ),
  );
}
