import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v24_student_app/global/ui/text_field/decoration/text_field_decoration.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.labelText,
    this.errorText,
    this.autofocus = false,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.obscureText = false,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.borderRadius = 8.0,
    this.keyboardType,
    this.onActionClicked,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.prefixText,
    this.prefixTextColor,
    this.prefixIcon,
    this.readOnly = false,
    this.enableInteractiveSelection = false,
  }) : super(key: key);

  final String? labelText;
  final String? errorText;
  final bool autofocus;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool obscureText;
  final String? hintText;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final double borderRadius;
  final TextInputType? keyboardType;
  final Function(String)? onActionClicked;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final String? prefixText;
  final Color? prefixTextColor;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool enableInteractiveSelection;

  @override
  Widget build(BuildContext context) {
    return TextFieldDecoration(
      labelText: labelText,
      errorText: errorText,
      child: TextField(
        onTap: onTap,
        onChanged: onChanged,
        autofocus: autofocus,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: keyboardType,
        onSubmitted: (value) {
          if (nextFocusNode != null) FocusScope.of(context).requestFocus(nextFocusNode);
          if (onActionClicked != null) onActionClicked!.call(value);
        },
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 13,
        ).montserrat(fontWeight: AppFonts.regular),
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        maxLength: maxLength,
        textInputAction: textInputAction,
        focusNode: focusNode,
        obscureText: obscureText,
        cursorColor: AppColors.borderColor,
        inputFormatters: inputFormatters,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: textCapitalization,
        textAlign: textAlign,
        readOnly: readOnly,
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 14.5, bottom: 14.5, left: 20.0, right: 14.0),
          filled: false,
          alignLabelWithHint: true,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.black.withOpacity(0.4), fontSize: 13.0)
              .montserrat(fontWeight: AppFonts.regular),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
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
      ),
    );
  }
}
