import 'package:shared_preferences/shared_preferences.dart';

const String DISPLAY_ONBOARDING = 'DISPLAY_ONBOARDING';
const String USER_ID = 'USER_ID';
const String PIN_CODE = 'PIN_CODE';

///SessionState for manage values in shared prefs
class SessionState {
  SessionState._();

  factory SessionState() => _instance;

  static final _instance = SessionState._();

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
        clearSessionData(),
        setUserId(userId),
      ]);
    }
    return Future.value();
  }

  Future<void> setUserId(String userId) {
    return _sharedPreferences.setString(USER_ID, userId);
  }

  String? getUserId() {
    return _sharedPreferences.getString(USER_ID);
  }

  Future<bool> setPinCode(String pinCode) {
    return _sharedPreferences.setString(PIN_CODE, pinCode);
  }

  bool? pinConfigured() {
    var pin = _sharedPreferences.getString(PIN_CODE);
    return pin != null && pin.isNotEmpty;
  }

  Future<void> clearSessionData() {
    return Future.wait([
      _sharedPreferences.remove(USER_ID),
      _sharedPreferences.remove(PIN_CODE),
    ]);
  }
}
