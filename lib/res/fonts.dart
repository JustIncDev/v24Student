import 'package:flutter/rendering.dart';

const String montserratFamily = 'Montserrat';

class AppFonts {
  static const FontWeight black = FontWeight.w900;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight thin = FontWeight.w100;
}

extension AppFontsExtension on TextStyle {
  TextStyle montserrat({FontWeight? fontWeight}) {
    return this.copyWith(fontFamily: montserratFamily, fontWeight: fontWeight);
  }
}
