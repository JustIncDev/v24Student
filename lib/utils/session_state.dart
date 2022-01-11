import 'package:shared_preferences/shared_preferences.dart';

const String DISPLAY_ONBOARDING = 'DISPLAY_ONBOARDING';

class SessionState {
  SessionState._();

  factory SessionState() => instance;

  static final instance = SessionState._();

  late SharedPreferences _sharedPreferences;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setOnboardingFlag(bool value) {
    return _sharedPreferences.setBool(DISPLAY_ONBOARDING, value);
  }

  bool getOnboardingFlag() {
    return _sharedPreferences.getBool(DISPLAY_ONBOARDING) ?? false;
  }
}
