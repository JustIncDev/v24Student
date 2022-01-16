import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

final validPasswordCharactersRegExp =
    RegExp(r'^[a-zA-Z0-9_!"#\$%&`\(\)\*\+,-\./:;<=>/?@\[\]\\\^_\{\}\|~]+$');
final validPhoneCharactersRegExp = RegExp(r'^[0-9_\+]+$');

class TextUtils {
  static bool isValidPassword(String password) {
    return validPasswordCharactersRegExp.hasMatch(password);
  }

  static bool isValidPhoneSymbols(String phone) {
    return validPhoneCharactersRegExp.hasMatch(phone);
  }

  static String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
