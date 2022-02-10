import 'package:flutter/material.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

enum PrimaryButtonStyle {
  standard,
  disabled,
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.onPressed,
    this.titleId,
    this.titleText,
    this.style = PrimaryButtonStyle.standard,
    this.elevation = 10.0,
    this.child,
    this.disabledColor,
    this.backgroundColor,
    this.borderSide,
    this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final StringId? titleId;
  final String? titleText;
  final PrimaryButtonStyle style;
  final double elevation;
  final Widget? child;
  final Color? disabledColor;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return _getDisabledColor();
          }
          return _getColor(); // Defer to the widget's default.
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return _getDisabledTextColor();
          }
          return _getTextColor(); // Defer to the widget's default.
        }),
        shadowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          return AppColors.shadowColor.withOpacity(0.2);
        }),
        elevation: MaterialStateProperty.all(elevation),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            side: borderSide ?? BorderSide.none,
          ),
        ),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((states) {
          if (states.contains(MaterialState.disabled)) {
            return const EdgeInsets.symmetric(vertical: 16.5);
          }
          return EdgeInsets.zero;
        }),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed) ? _getOverlayColor() : null;
          },
        ),
      ),
      child: onPressed != null && style != PrimaryButtonStyle.disabled
          ? Ink(
              decoration: BoxDecoration(
                gradient: _getGradientColor(),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.5, horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HorizontalSpace(18.0),
                        Text(
                          titleId != null ? getStringById(context, titleId!) : titleText ?? '',
                          style: const TextStyle(
                            fontSize: 13.0,
                          ).montserrat(fontWeight: AppFonts.semiBold),
                        ),
                        if (icon != null) icon! else const HorizontalSpace(18.0),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                titleId != null ? getStringById(context, titleId!) : titleText ?? '',
                style: const TextStyle(
                  fontSize: 13.0,
                ).montserrat(fontWeight: AppFonts.semiBold),
              ),
            ),
    );
  }

  Gradient _getGradientColor() {
    switch (style) {
      default:
        return const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.blueRaspberry,
            AppColors.hooloovooBlue,
            AppColors.sixteenMillionPink,
          ],
        );
    }
  }

  Color _getColor() {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    switch (style) {
      case PrimaryButtonStyle.standard:
        return AppColors.transparent;
      case PrimaryButtonStyle.disabled:
        return AppColors.disabledColor;
    }
  }

  Color _getTextColor() {
    switch (style) {
      case PrimaryButtonStyle.standard:
        return AppColors.white;
      case PrimaryButtonStyle.disabled:
        return AppColors.royalBlue;
    }
  }

  Color _getDisabledColor() {
    var disabledColor = this.disabledColor;
    if (disabledColor != null) {
      return disabledColor;
    }
    switch (style) {
      case PrimaryButtonStyle.standard:
        return AppColors.disabledColor;
      default:
        return AppColors.disabledColor;
    }
  }

  Color _getDisabledTextColor() {
    switch (style) {
      case PrimaryButtonStyle.standard:
        return AppColors.royalBlue;
      default:
        return AppColors.royalBlue;
    }
  }

  Color _getOverlayColor() {
    switch (style) {
      case PrimaryButtonStyle.standard:
        return AppColors.white10;
      default:
        return AppColors.white10;
    }
  }
}
