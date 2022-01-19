import 'dart:math';

import 'package:flutter/material.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_item_widget.dart';
import 'package:v24_student_app/utils/color.dart';

enum FavoriteItemType {
  subject,
  teacher,
}

class FavoriteGridWidget extends StatelessWidget {
  const FavoriteGridWidget({
    Key? key,
    this.type = FavoriteItemType.subject,
    this.favoriteItems,
    this.selectedItems,
  }) : super(key: key);

  final FavoriteItemType type;
  final List<FavoriteObject>? favoriteItems;
  final List<String>? selectedItems;

  @override
  Widget build(BuildContext context) {
    var safeItems = favoriteItems;
    if (safeItems != null && safeItems.isNotEmpty) {
      return CustomScrollView(
        primary: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 25.0,
              mainAxisSpacing: 18.0,
              children: List.generate(
                favoriteItems?.length ?? 0,
                (index) => FavoriteItemWidget(
                  title: safeItems[index].title,
                  iconPath: safeItems[index].imagePath ?? '',
                  backgroundColor: _getColorCode(safeItems[index].color ?? '0xFFFFFFFF'),
                  itemType: type,
                  // subSubjectsCount: type == FavoriteItemType.subject
                  //     ? (safeItems[index] as FavoriteSubject).subSubjects?.length
                  //     : null,
                  subSubjectsCount: null,
                  selected: selectedItems?.contains(safeItems[index].id) ?? false,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Offstage();
    }
  }

  int _getColorCode(String? color) {
    if (type == FavoriteItemType.teacher) {
      var colors = ColorUtils.getTeachersColorsCodes();
      return colors[Random().nextInt(colors.length)];
    } else {
      return int.parse(color ?? '0xFFFFFFFF');
    }
  }
}
