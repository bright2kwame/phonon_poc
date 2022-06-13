import 'package:flutter/material.dart';

class AppColor {
  static get primaryColor => HexColor.fromHex(ColorResource.primaryColor);
  static get primaryLightColor =>
      HexColor.fromHex(ColorResource.primaryLightColor);
  static get primaryDarkColor =>
      HexColor.fromHex(ColorResource.primaryDarkColor);
  static get bgColor => HexColor.fromHex(ColorResource.bgColor);
  static get secondaryColor => HexColor.fromHex(ColorResource.secondaryColor);

  static MaterialColor primaryMaterialColor = MaterialColor(0xFF6444d5, color);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Map<int, Color> color = {
  50: const Color.fromRGBO(100, 68, 213, .1),
  100: const Color.fromRGBO(100, 68, 213, 0.2),
  200: const Color.fromRGBO(100, 68, 213, .3),
  300: const Color.fromRGBO(100, 68, 213, .4),
  400: const Color.fromRGBO(100, 68, 213, .5),
  500: const Color.fromRGBO(100, 68, 213, .6),
  600: const Color.fromRGBO(100, 68, 213, .7),
  700: const Color.fromRGBO(100, 68, 213, .8),
  800: const Color.fromRGBO(100, 68, 213, .9),
  900: const Color.fromRGBO(100, 68, 213, 1),
};

class ColorResource {
  static get primaryColor => "#6444d5";
  static get primaryLightColor => "#9A71ff";
  static get primaryDarkColor => "#2718A3";
  static get secondaryColor => "#6444d5";
  static get tertiaryColor => "#FF8329";
  static get bgColor => "#F5F5F6";
}
