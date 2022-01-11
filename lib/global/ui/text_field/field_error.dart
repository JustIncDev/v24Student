import 'package:flutter/widgets.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class FieldError {
  const FieldError({this.message, this.stringId});

  const FieldError.none()
      : message = null,
        stringId = null;

  final String? message;
  final StringId? stringId;

  bool isNone() {
    return message == null && stringId == null;
  }

  String? getMessage(BuildContext context) {
    if (isNone()) {
      return null;
    } else {
      return message ?? getStringById(context, stringId!);
    }
  }
}
