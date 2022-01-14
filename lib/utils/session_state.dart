import 'package:shared_preferences/shared_preferences.dart';

const String DISPLAY_ONBOARDING = 'DISPLAY_ONBOARDING';
const String USER_ID = 'USER_ID';

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

  Future<void> checkUserId(String userId) {
    if (userId != _sharedPreferences.getString(USER_ID)) {
      return Future.wait([
        setUserId(userId),
      ]);
    }
    return Future.value();
  }

  Future<void> setUserId(String userId) {
    return _sharedPreferences.setString(USER_ID, userId);
  }
}
