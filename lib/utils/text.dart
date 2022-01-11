final validPasswordCharactersRegExp = RegExp(r'^[a-zA-Z0-9_!"#\$%&`\(\)\*\+,-\./:;<=>/?@\[\]\\\^_\{\}\|~]+$');
final validPhoneCharactersRegExp = RegExp(r'^[0-9_\+]+$');

class TextUtils {
  static bool isValidPassword(String password) {
    return validPasswordCharactersRegExp.hasMatch(password);
  }

  static bool isValidPhoneSymbols(String phone) {
    return validPhoneCharactersRegExp.hasMatch(phone);
  }
}