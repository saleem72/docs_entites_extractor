//

import 'package:flutter/material.dart';

import 'pallet.dart';

class ColorSchemeProvider {
  static ColorScheme darkFromCorePalette = ColorScheme(
    brightness: Brightness.dark,

    primary: Pallet.primary.shade800,
    onPrimary: Pallet.primary.shade50,
    primaryContainer: Pallet.primary.shade300,
    onPrimaryContainer: Pallet.primary.shade900,
    inversePrimary: Pallet.primary.shade400,

    secondary: Pallet.secondary.shade400,
    onSecondary: Pallet.secondary.shade100,
    secondaryContainer: Pallet.secondary.shade900,
    onSecondaryContainer: Pallet.secondary.shade100,

    tertiary: Pallet.tertiary.shade400,
    onTertiary: Pallet.tertiary.shade100,
    tertiaryContainer: Pallet.tertiary.shade900,
    onTertiaryContainer: Pallet.tertiary.shade100,

    error: Pallet.error.shade500,
    onError: Pallet.error.shade100,
    errorContainer: Pallet.error.shade200,
    onErrorContainer: Pallet.error.shade900,

    // background: Pallet.neutral.shade900,
    // onBackground: Pallet.neutral.shade50,
    surface: Pallet.neutral.shade800,
    onSurface: Pallet.neutral.shade50,
    // surfaceVariant: Pallet.neutralVariant.shade900,
    onSurfaceVariant: Pallet.neutralVariant.shade300,
    outline: Pallet.neutralVariant.shade500,
    outlineVariant: Pallet.neutralVariant.shade800,
    shadow: Colors.white24, // Pallet.neutral.shade50,
    scrim: Pallet.neutral.shade50,
    inverseSurface: Pallet.neutral.shade200,
    // inverseOnSurface: Pallet.neutral.shade900, // shade 95,
  );

  static ColorScheme lightFromCorePalette = ColorScheme(
    brightness: Brightness.light,

    primary: Pallet.primary.shade500,
    onPrimary: Pallet.primary.shade50, // Pallet.primary.shade50,
    primaryContainer: Pallet.primary.shade200,
    onPrimaryContainer: Pallet.primary.shade800,
    inversePrimary: Pallet.primary.shade300,

    secondary: Pallet.secondary.shade500,
    onSecondary: Pallet.secondary.shade50,
    secondaryContainer: Pallet.secondary.shade300,
    onSecondaryContainer: Pallet.secondary.shade900,

    tertiary: Pallet.tertiary.shade800,
    onTertiary: Pallet.tertiary.shade200,
    tertiaryContainer: Pallet.tertiary.shade300,
    onTertiaryContainer: Pallet.tertiary.shade900,

    error: Pallet.error.shade800,
    onError: Pallet.error.shade200,
    errorContainer: Pallet.error.shade300,
    onErrorContainer: Pallet.error.shade800,

    // background: Colors.white,
    // onBackground: Pallet.neutral.shade900,
    surface: Colors.white,
    onSurface: Pallet.neutral.shade900,
    // surfaceVariant: Pallet.neutralVariant.shade300,
    onSurfaceVariant: Pallet.neutralVariant.shade800,
    outline: Pallet.neutralVariant.shade700,
    outlineVariant: Pallet.neutralVariant.shade300,
    shadow: Pallet.neutral.shade200,
    scrim: Pallet.neutral.shade200,
    inverseSurface: Pallet.neutral.shade900,
    // inverseOnSurface: Pallet.neutral.get(20),
  );
}
