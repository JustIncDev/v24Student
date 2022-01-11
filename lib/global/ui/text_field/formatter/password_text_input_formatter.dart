import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:v24_student_app/utils/text.dart';

class PasswordTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    if (newValue.text.length > 35) {
      return oldValue;
    }
    if (!TextUtils.isValidPassword(newValue.text)) {
      // sendAppMessage(AppBusMessage(stringId: StringId.textSymbolError, modal: false));
      return oldValue;
    }
    return newValue;
  }
}
