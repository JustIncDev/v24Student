import 'package:flutter/material.dart';
import 'package:v24_student_app/res/colors.dart';

class CodeContainerRow extends StatelessWidget {
  const CodeContainerRow({
    Key? key,
    this.codePosition = 0,
  }) : super(key: key);

  final int codePosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Padding(
          padding: EdgeInsets.only(right: index == 5 ? 0.0 : 14.0),
          child: CodeElement(enabled: index < codePosition),
        ),
      ),
    );
  }
}

class CodeElement extends StatelessWidget {
  const CodeElement({
    Key? key,
    this.enabled = false,
  }) : super(key: key);

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.0,
      height: 14.0,
      decoration: BoxDecoration(
        color: enabled ? AppColors.royalBlue : AppColors.disabledColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
