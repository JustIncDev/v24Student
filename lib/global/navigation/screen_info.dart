import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:v24_student_app/feature/login/login_screen.dart';
import 'package:v24_student_app/feature/onboarding/onboarding_screen.dart';
import 'package:v24_student_app/feature/signup/credentials/signup_credentials_screen.dart';
import 'package:v24_student_app/feature/signup/sms_code/signup_code_screen.dart';
import 'package:v24_student_app/global/bloc.dart';

enum ScreenName {
  login,
  signUpCredentials,
  signUpCode,
  onboarding,
}

class ScreenInfo {
  final ScreenName name;
  final Map<String, Object>? params;
  final Completer<Object>? resultCompleter;

  const ScreenInfo({required this.name, this.params, this.resultCompleter});

  factory ScreenInfo.withResult({required ScreenName name, Map<String, Object>? params}) {
    return ScreenInfo(name: name, params: params, resultCompleter: Completer<Object>());
  }
}

Page<void> toPage(ScreenInfo info, BuildContext context) {
  switch (info.name) {
    case ScreenName.login:
      return LoginScreen.buildPage(
          params: info.params, blocFactory: Provider.of<BlocFactory>(context));
    case ScreenName.signUpCredentials:
      return SignUpCredentialsScreen.buildPage(
          params: info.params, blocFactory: Provider.of<BlocFactory>(context));
    case ScreenName.signUpCode:
      return SignUpCodeScreen.buildPage(
        params: info.params,
        blocFactory: Provider.of<BlocFactory>(context),
      );
    case ScreenName.onboarding:
      return OnboardingScreen.buildPage(params: info.params);
  }
}
