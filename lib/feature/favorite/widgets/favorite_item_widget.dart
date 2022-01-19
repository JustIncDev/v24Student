import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_grid_widget.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';

class FavoriteItemWidget extends StatefulWidget {
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
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  @override
  Widget build(BuildContext context) {
    var itemBoxContainer = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: widget.itemType == FavoriteItemType.teacher
                ? BorderRadius.circular(70.0)
                : BorderRadius.circular(20.0),
            color: Color(widget.backgroundColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(21.0),
            child: _getIconImage(),
          ),
        ),
        if (widget.itemType == FavoriteItemType.teacher)
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.iconPath),
                onError: (_, __) {},
              ),
            ),
          ),
      ],
    );

    var itemWidget = widget.selected
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
          children: [
            itemWidget,
            const VerticalSpace(10.0),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.0, color: AppColors.black)
                  .montserrat(fontWeight: AppFonts.semiBold),
            ),
          ],
        ),
        if (widget.subSubjectsCount != null && widget.subSubjectsCount! > 0)
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: Text(
              widget.subSubjectsCount.toString(),
              style: const TextStyle(fontSize: 11.0, color: AppColors.white)
                  .montserrat(fontWeight: AppFonts.semiBold),
            ),
          ),
      ],
    );
  }

  Widget _getIconImage() {
    switch (widget.itemType) {
      case FavoriteItemType.subject:
        if (widget.iconPath.contains('.svg')) {
          return SvgPicture.network(
            widget.iconPath,
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
