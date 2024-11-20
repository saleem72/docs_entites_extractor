//

import 'package:flutter/material.dart';

class Pallet {
  Pallet._internal();
  static const Color lightText = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF000000);

  static const MaterialColor primary = MaterialColor(
    0xFF16243f,
    {
      50: Color(0xFFe8e9ec),
      100: Color(0xFFb7bbc3),
      200: Color(0xFF949aa7),
      300: Color(0xFF636c7e),
      400: Color(0xFF455065),
      500: Color(0xFF16243f),
      600: Color(0xFF142139),
      700: Color(0xFF101a2d),
      800: Color(0xFF0c1423),
      900: Color(0xFF090f1a),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xFFf8c918,
    {
      50: Color(0xFFfefae8),
      100: Color(0xFFfdeeb7),
      200: Color(0xFFfce695),
      300: Color(0xFFfadb64),
      400: Color(0xFFf9d446),
      500: Color(0xFFf8c918),
      600: Color(0xFFe2b716),
      700: Color(0xFFb08f11),
      800: Color(0xFF886f0d),
      900: Color(0xFF68540a),
    },
  );

  static const MaterialColor tertiary = MaterialColor(
    0xFF7e525d,
    {
      50: Color(0xFFf2eeef),
      100: Color(0xFFd7c9cd),
      200: Color(0xFFc4afb4),
      300: Color(0xFFa98b92),
      400: Color(0xFF98757d),
      500: Color(0xFF7e525d),
      600: Color(0xFF734b55),
      700: Color(0xFF593a42),
      800: Color(0xFF452d33),
      900: Color(0xFF352227),
    },
  );

  static const MaterialColor error = MaterialColor(
    0xFFfc7171,
    {
      50: Color(0xFFfff1f1),
      100: Color(0xFFfed3d3),
      200: Color(0xFFfebebe),
      300: Color(0xFFfda0a0),
      400: Color(0xFFfd8d8d),
      500: Color(0xFFfc7171),
      600: Color(0xFFe56767),
      700: Color(0xFFb35050),
      800: Color(0xFF8b3e3e),
      900: Color(0xFF6a2f2f),
    },
  );

  static const MaterialColor neutralVariant = MaterialColor(
    0xFFebf0f0,
    {
      50: Color(0xFFfdfefe),
      100: Color(0xFFf9fafa),
      200: Color(0xFFf6f8f8),
      300: Color(0xFFf2f5f5),
      400: Color(0xFFeff3f3),
      500: Color(0xFFebf0f0),
      600: Color(0xFFd6dada),
      700: Color(0xFFa7aaaa),
      800: Color(0xFF818484),
      900: Color(0xFF636565),
    },
  );

  static const MaterialColor neutral = MaterialColor(
    0xFF323033,
    {
      50: Color(0xFFebeaeb),
      100: Color(0xFFbfbfc0),
      200: Color(0xFFa1a0a1),
      300: Color(0xFF767476),
      400: Color(0xFF5b595c),
      500: Color(0xFF323033),
      600: Color(0xFF2e2c2e),
      700: Color(0xFF242224),
      800: Color(0xFF1c1a1c),
      900: Color(0xFF151415),
    },
  );
}
