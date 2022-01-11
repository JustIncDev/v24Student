import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/icons.dart';

const _appleIconSizeScale = 28 / 44;
const _appleButtonHeight = 44.0;
const _fontSize = _appleButtonHeight * 0.43;

enum SocialMediaType {
  apple,
  facebook,
  google,
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    this.type = SocialMediaType.apple,
  }) : super(key: key);

  final SocialMediaType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _appleButtonHeight,
      decoration: BoxDecoration(
        color: _getButtonColor(),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _getSocialIcon(),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor() {
    switch (type) {
      case SocialMediaType.apple:
        return AppColors.black;
      case SocialMediaType.facebook:
        return AppColors.facebookColor;
      case SocialMediaType.google:
        return AppColors.googleColor;
    }
  }

  Widget _getSocialIcon() {
    switch (type) {
      case SocialMediaType.apple:
        return _buildAppleIcon();
      case SocialMediaType.facebook:
        return const ImageIcon(
          AppIcons.facebookIconAsset,
          color: AppColors.white,
        );
      case SocialMediaType.google:
        return const ImageIcon(
          AppIcons.googleIconAsset,
          color: AppColors.white,
        );
    }
  }

  Widget _buildAppleIcon() {
    return Container(
      width: _appleIconSizeScale * _appleButtonHeight,
      height: _appleIconSizeScale * _appleButtonHeight + 2,
      padding: const EdgeInsets.only(
        // Properly aligns the Apple icon with the text of the button
        bottom: (4 / 44) * _appleButtonHeight,
      ),
      child: Center(
        child: Container(
          width: _fontSize * (25 / 31),
          height: _fontSize,
          child: const CustomPaint(
            painter: AppleLogoPainter(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
