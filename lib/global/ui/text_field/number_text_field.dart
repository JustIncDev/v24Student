import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:v24_student_app/global/ui/text_field/decoration/text_field_decoration.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';

typedef OnCountryChanged = void Function(String countryName);

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key? key,
    this.labelText,
    this.errorText,
    this.borderRadius = 8.0,
    this.controller,
    this.focusNode,
    this.onCountryChanged,
  }) : super(key: key);

  final String? labelText;
  final String? errorText;
  final double borderRadius;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final OnCountryChanged? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldDecoration(
      labelText: labelText,
      errorText: errorText,
      child: IntlPhoneField(
        // controller: controller,
        focusNode: focusNode,
        style: const TextStyle(color: AppColors.black, fontSize: 13.0)
            .montserrat(fontWeight: AppFonts.regular),
        countryNameStyle: TextStyle(color: AppColors.black.withOpacity(0.4), fontSize: 13.0)
            .montserrat(fontWeight: AppFonts.regular),
        countryCodeStyle: const TextStyle(color: AppColors.black, fontSize: 13.0)
            .montserrat(fontWeight: AppFonts.regular),
        cursorColor: AppColors.borderColor,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 14.5, bottom: 14.5, left: 20.0, right: 14.0),
          filled: false,
          alignLabelWithHint: true,
          hintText: '000-000-000',
          hintStyle: TextStyle(color: AppColors.black.withOpacity(0.4), fontSize: 13.0)
              .montserrat(fontWeight: AppFonts.regular),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.disabledColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.accent50),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.accent),
          ),
        ),
        iconPosition: IconPosition.trailing,
        flagsButtonPadding: const EdgeInsets.only(left: 20.0, right: 16.0, top: 14.5, bottom: 14.5),
        showCountryFlag: false,
        dropDownIcon: SvgPicture.asset(
          AppIcons.arrowDownIcon,
          color: AppColors.borderColor,
        ),
        dropdownDecoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        dropdownTextStyle: const TextStyle(color: AppColors.black, fontSize: 13.0)
            .montserrat(fontWeight: AppFonts.regular),
        onChanged: (phone) {
          controller?.text = phone.completeNumber;
          print(phone.completeNumber);
        },
        onCountryChanged: (phone) {
          print('Country code changed to: ' + (phone.countryCode ?? ''));
          if (onCountryChanged != null) {
            onCountryChanged!(phone.countryName);
          }
        },
      ),
    );
  }
}
