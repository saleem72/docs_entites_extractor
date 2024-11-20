//

import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColor() {
    var hexColor = toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    final hex = int.parse(hexColor, radix: 16);
    return Color(hex);
  }
}
