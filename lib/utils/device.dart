import 'package:flutter/material.dart';

class DeviceUtils {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.height < 670;
  }

  static bool isThinScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 365;
  }

  static bool isDeviceWithStroke(BuildContext context) {
    return MediaQuery.of(context).viewPadding.bottom > 0;
  }
}