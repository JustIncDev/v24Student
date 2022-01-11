import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:v24_student_app/application.dart';
import 'package:v24_student_app/global/injector.dart';
import 'firebase_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'global/logger/logger.dart';

void main() async {
  await Future.wait([
    _prepareApplicationStart(),
  ]);
  _startApplication();
}

Future<void> _prepareApplicationStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GestureBinding.instance?.resamplingEnabled = true;
}

void _startApplication() {
  Log.info('---------------------------------------------------------------------------');
  Log.info('START V24Student');
  Log.info('---------------------------------------------------------------------------');

  runZonedGuarded(
    () {
      (Zone.current[#injector] as Injector).init().then((injector) {
        runApp(V24StudentApplication(injector: injector));
      });
    },
    (e, s) async {
      return Log.error('Unknown error', exc: e, stackTrace: s);
    },
    zoneValues: {#injector: Injector()},
  );
}
