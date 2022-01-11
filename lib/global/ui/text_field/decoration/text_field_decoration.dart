import 'package:flutter/material.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

class TextFieldDecoration extends StatelessWidget {
  const TextFieldDecoration({
    Key? key,
    required this.child,
    this.labelText,
    this.errorText,
  }) : super(key: key);

  final Widget child;
  final String? labelText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelDecorationWidget(labelText: labelText),
        child,
        _ErrorDecorationWidget(errorText: errorText),
      ],
    );
  }
}

class _LabelDecorationWidget extends StatelessWidget {
  const _LabelDecorationWidget({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        labelText ?? '',
        textAlign: TextAlign.start,
        style: const TextStyle(color: AppColors.royalBlue, fontSize: 13.0)
            .montserrat(fontWeight: AppFonts.semiBold),
      ),
    );
  }
}

class _ErrorDecorationWidget extends StatelessWidget {
  const _ErrorDecorationWidget({
    Key? key,
    this.errorText,
  }) : super(key: key);

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        errorText ?? '',
        textAlign: TextAlign.start,
        style: const TextStyle(color: AppColors.accent, fontSize: 11.0)
            .montserrat(fontWeight: AppFonts.semiBold),
      ),
    );
  }
}
