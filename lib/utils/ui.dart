import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiUtils {
  static Page createPlatformPage({
    required LocalKey? key,
    required Widget child,
    bool fullscreenDialog = false,
  }) {
    if (Platform.isIOS) {
      return CupertinoPage<void>(
        key: key,
        child: child,
        fullscreenDialog: fullscreenDialog,
        name: key is ValueKey ? key.value : null,
      );
    } else {
      return MaterialPage<void>(
        key: key,
        child: child,
        fullscreenDialog: fullscreenDialog,
        name: key is ValueKey ? key.value : null,
      );
    }
  }
}
