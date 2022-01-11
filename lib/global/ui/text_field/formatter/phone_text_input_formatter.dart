import 'package:flutter/services.dart';
import 'package:v24_student_app/utils/text.dart';

class PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    if (!TextUtils.isValidPhoneSymbols(newValue.text)) {
      return oldValue;
    }
    if (newValue.text.length > 1 &&
        (newValue.text.indexOf('+') > 1 || newValue.text.lastIndexOf('+') > 1)) {
      return oldValue;
    }
    if (newValue.text.replaceAll('+', '').length > 11) {
      return oldValue;
    }
    return newValue;
  }
}
