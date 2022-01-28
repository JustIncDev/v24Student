import 'package:flutter/material.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

class SurveyStatusWidget extends StatelessWidget {
  const SurveyStatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getContainerColor(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        status,
        style: TextStyle(
          color: _getTextColor(),
          fontSize: 12.0,
          letterSpacing: -0.3,
        ).montserrat(fontWeight: AppFonts.semiBold),
      ),
    );
  }

  Color _getContainerColor() {
    switch (status) {
      case 'Started':
        return AppColors.startedStatusColor;
      case 'Finished':
        return AppColors.disabledColor.withOpacity(0.85);
      case 'Creation':
        return AppColors.creationStatusColor;
      default:
        return AppColors.startedStatusColor;
    }
  }

  Color _getTextColor() {
    switch (status) {
      case 'Started':
        return AppColors.startedTextColor;
      case 'Finished':
        return AppColors.royalBlue;
      case 'Creation':
        return AppColors.creationTextColor;
      default:
        return AppColors.startedTextColor;
    }
  }
}
