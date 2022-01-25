import 'package:flutter/material.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/images.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class LargePlaceholder extends StatelessWidget {
  const LargePlaceholder({
    Key? key,
    this.titleId,
    this.descriptionId,
    this.imageProvider = AppImages.surveyPlaceholderImageAsset,
    this.buttonTextId,
    this.onButtonTap,
  }) : super(key: key);

  final StringId? titleId;
  final StringId? descriptionId;
  final ImageProvider imageProvider;
  final StringId? buttonTextId;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(image: imageProvider),
          const VerticalSpace(22),
          if (hasTitle())
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                getDisplayTitle(context),
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                ).montserrat(fontWeight: AppFonts.semiBold),
              ),
            ),
          if (hasDescription())
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                getDisplayDescription(context),
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.black.withOpacity(0.9), fontSize: 14)
                    .montserrat(fontWeight: AppFonts.semiBold),
              ),
            ),
          if (hasButton())
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: PrimaryButton(
                titleId: buttonTextId,
                onPressed: onButtonTap,
              ),
            ),
        ],
      ),
    );
  }

  bool hasTitle() => titleId != null;

  bool hasDescription() => descriptionId != null;

  bool hasButton() => buttonTextId != null;

  String getDisplayDescription(BuildContext context) {
    return getStringById(context, descriptionId!);
  }

  String getDisplayTitle(BuildContext context) {
    return getStringById(context, titleId!);
  }
}
