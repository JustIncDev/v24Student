import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_grid_widget.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.itemType,
    this.subSubjectsCount,
    this.selected = false,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final int backgroundColor;
  final FavoriteItemType itemType;
  final int? subSubjectsCount;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Widget itemBoxContainer = Container(
      decoration: BoxDecoration(
        shape: itemType == FavoriteItemType.teacher ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: itemType == FavoriteItemType.teacher
            ? BorderRadius.circular(70.0)
            : BorderRadius.circular(20.0),
        color: Color(backgroundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: SvgPicture.network(
          iconPath,
        ),
      ),
    );

    var itemWidget = selected
        ? Stack(
            alignment: Alignment.center,
            children: [
              const Image(image: AppIcons.checkIconAsset),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: itemBoxContainer,
                ),
              )
            ],
          )
        : itemBoxContainer;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemWidget,
            const VerticalSpace(10.0),
            Text(
              title,
              style: const TextStyle(fontSize: 12.0, color: AppColors.black)
                  .montserrat(fontWeight: AppFonts.semiBold),
            ),
          ],
        ),
        if (subSubjectsCount != null && subSubjectsCount! > 0)
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: Text(
              subSubjectsCount.toString(),
              style: const TextStyle(fontSize: 11.0, color: AppColors.white)
                  .montserrat(fontWeight: AppFonts.semiBold),
            ),
          ),
      ],
    );
  }
}
