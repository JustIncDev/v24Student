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
    required this.selected,
    this.bottomSheet = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final int backgroundColor;
  final FavoriteItemType itemType;
  final int? subSubjectsCount;
  final bool selected;
  final bool bottomSheet;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var itemBoxContainer = SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: itemType == FavoriteItemType.teacher
                  ? BorderRadius.circular(70.0)
                  : BorderRadius.circular(20.0),
              color: Color(backgroundColor),
              boxShadow: [
                BoxShadow(
                  color: Color(backgroundColor).withOpacity(0.15),
                  blurRadius: 20.0,
                  offset: const Offset(0, 10.0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: _getIconImage(),
            ),
          ),
          if (itemType == FavoriteItemType.teacher)
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(iconPath),
                  onError: (_, __) {},
                ),
              ),
            ),
        ],
      ),
    );

    var itemWidget = selected
        ? Stack(
            alignment: Alignment.center,
            children: [
              itemBoxContainer,
              ClipRect(
                child: Container(
                  width: 80,
                  height: 80,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: itemType == FavoriteItemType.teacher
                            ? BorderRadius.circular(70.0)
                            : BorderRadius.circular(20.0),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              const Image(
                image: AppIcons.checkIconAsset,
                color: AppColors.white,
              ),
            ],
          )
        : itemBoxContainer;

    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              child: itemWidget,
              onTap: onTap,
              borderRadius: itemType == FavoriteItemType.teacher
                  ? BorderRadius.circular(70.0)
                  : BorderRadius.circular(20.0),
            ),
            const VerticalSpace(10.0),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: bottomSheet ? 14.0 : 12.0, color: AppColors.black)
                    .montserrat(fontWeight: AppFonts.semiBold),
              ),
            ),
          ],
        ),
        if (subSubjectsCount != null && subSubjectsCount! > 0 && !bottomSheet)
          Align(
            alignment: const Alignment(1, -1),
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                color: AppColors.black,
              ),
              child: Center(
                child: Text(
                  subSubjectsCount.toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(fontSize: 11.0, color: AppColors.white)
                      .montserrat(fontWeight: AppFonts.semiBold),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _getIconImage() {
    switch (itemType) {
      case FavoriteItemType.subject:
        if (iconPath.contains('.svg')) {
          return SvgPicture.network(
            iconPath,
            width: 38.0,
            height: 38.0,
            color: AppColors.white,
          );
        } else {
          return SvgPicture.asset(
            AppIcons.sampleSubjectIcon,
            color: AppColors.white,
            width: 38.0,
            height: 38.0,
          );
        }
      case FavoriteItemType.teacher:
        return SvgPicture.asset(
          AppIcons.sampleTeacherIcon,
          color: AppColors.white,
          width: 38.0,
          height: 38.0,
        );
    }
  }
}
