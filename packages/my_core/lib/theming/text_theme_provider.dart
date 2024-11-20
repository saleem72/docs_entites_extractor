//

import 'package:flutter/material.dart';
// import 'package:my_core/theming/app_colors.dart';

class TextThemeProvider {
  static TextTheme generate(Brightness brightness) {
    var baseTheme = ThemeData(brightness: brightness);
    return baseTheme.textTheme;
    // return GoogleFonts.poppinsTextTheme(baseTheme.textTheme);
    // .copyWith(
    //   titleSmall: GoogleFonts.poppins().copyWith(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 16,
    //     color: AppColors.darkText,
    //   ),
    //   titleMedium: GoogleFonts.sourceSerifPro().copyWith(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 18,
    //     color: AppColors.darkText,
    //   ),
    //   titleLarge: GoogleFonts.sourceSerifPro().copyWith(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 24,
    //     color: AppColors.darkText,
    //   ),
    //   displaySmall: GoogleFonts.sourceSerifPro().copyWith(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 34,
    //     color: AppColors.darkText,
    //   ),
    // );
  }
}
