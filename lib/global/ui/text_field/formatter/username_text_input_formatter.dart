import 'package:flutter/services.dart';


class UserNameTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 25) {
      return oldValue;
    }
    // if (newValue.text.contains(' ')) {
    //   sendAppMessage(AppBusMessage(stringId: StringId.textSymbolError, modal: false));
    //   return oldValue;
    // }
    return newValue;
  }
}
