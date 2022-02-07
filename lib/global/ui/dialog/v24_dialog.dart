import 'package:flutter/material.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

import '../space.dart';

class V24Dialog extends StatelessWidget {
  const V24Dialog({
    Key? key,
    this.title,
    this.description,
    this.header,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Widget? description;
  final Widget? header;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final description = this.description;
    final header = this.header;

    return V24BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: header,
            ),
          if (title != null)
            DefaultTextStyle(
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ).montserrat(fontWeight: AppFonts.semiBold),
              child: title,
            ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                ).montserrat(fontWeight: AppFonts.regular),
                child: description,
              ),
            ),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildActions() {
    var actions = this.actions;
    var widgets = <Widget>[];

    var iterator = actions?.iterator;

    if (iterator != null) {
      if (iterator.moveNext()) {
        widgets.add(iterator.current);
      }

      while (iterator.moveNext()) {
        widgets.add(const VerticalSpace(10.0));
        widgets.add(iterator.current);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        ),
      ),
    );
  }
}

class V24BaseDialog extends StatelessWidget {
  const V24BaseDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: child,
      ),
    );
  }
}
