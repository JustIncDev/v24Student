import 'package:flutter/material.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_item_widget.dart';

enum FavoriteItemType {
  subject,
  teacher,
}

class FavoriteGridWidget extends StatelessWidget {
  const FavoriteGridWidget({
    Key? key,
    this.type = FavoriteItemType.subject,
    this.favoriteItemsMap,
  }) : super(key: key);

  final FavoriteItemType type;
  final Map<FavoriteObject, bool>? favoriteItemsMap;

  @override
  Widget build(BuildContext context) {
    var safeItems = favoriteItemsMap?.keys.toList();
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
                favoriteItemsMap?.length ?? 0,
                (index) => FavoriteItemWidget(
                  title: safeItems[index].title,
                  iconPath: safeItems[index].imagePath,
                  backgroundColor: safeItems[index].color,
                  itemType: type,
                  subSubjectsCount: type == FavoriteItemType.subject
                      ? (safeItems[index] as FavoriteSubject).subSubjects?.length
                      : null,
                  selected: favoriteItemsMap?[index] ?? false,
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
}
