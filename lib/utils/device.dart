import 'package:flutter/material.dart';

class DeviceUtils {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.height < 670;
  }
}