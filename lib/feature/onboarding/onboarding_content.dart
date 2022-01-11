import 'package:flutter/material.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

enum OnboardingPageNumber {
  first,
  second,
  third,
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    this.pageNumber = OnboardingPageNumber.first,
  }) : super(key: key);

  final StringId title;
  final StringId description;
  final ImageProvider image;
  final OnboardingPageNumber pageNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getStringById(context, title),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24.0,
          ).montserrat(fontWeight: AppFonts.semiBold),
        ),
        const VerticalSpace(10.0),
        Text(
          getStringById(context, description),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14.0,
          ).montserrat(fontWeight: AppFonts.semiBold),
        ),
        Expanded(
          child: ClipPath(
            clipper: OnboardingClipper(),
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              padding: const EdgeInsets.only(top: 100.0),
              child: Image(image: image),
            ),
          ),
        )
      ],
    );
  }
}

class OnboardingClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var firstBasicPoint = Offset(0, size.height * 0.1);
    var firstHandlePoint = Offset(size.width * 0.35, size.height * 0.0001);
    var point = Offset(size.width * 0.7, size.height * 0.15);
    var secondHandlePoint = Offset(size.width * 0.5, size.height * 0.2);

    var path = Path()
      ..lineTo(firstBasicPoint.dx, firstBasicPoint.dy)
      ..cubicTo(firstHandlePoint.dx, firstHandlePoint.dy, secondHandlePoint.dx,
          secondHandlePoint.dy, point.dx, point.dy)
      ..lineTo(size.width, size.height * 0.1)
      ..lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
