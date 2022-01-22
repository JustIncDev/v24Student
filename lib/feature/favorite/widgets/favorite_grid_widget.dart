import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/feature/favorite/bloc/favorite_bloc.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_item_widget.dart';
import 'package:v24_student_app/utils/color.dart';

import 'favorite_subjects_modal_widget.dart';

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
  final Object? selectedItems;

  @override
  Widget build(BuildContext context) {
    var safeItems = favoriteItems;
    var state = BlocProvider.of<FavoriteBloc>(context).state;

    if (safeItems != null && safeItems.isNotEmpty) {
      return CustomScrollView(
        primary: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverGrid.count(
              childAspectRatio:
                  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
              crossAxisCount: 3,
              crossAxisSpacing: 25.0,
              children: List.generate(
                favoriteItems?.length ?? 0,
                (index) => FavoriteItemWidget(
                  title: safeItems[index].title,
                  iconPath: safeItems[index].imagePath ?? '',
                  backgroundColor: _getColorCode(safeItems[index].color ?? '0xFFFFFFFF', index),
                  itemType: type,
                  subSubjectsCount: state.selectedSubSubjectsCount(safeItems[index].id),
                  selected: state.isSelected(safeItems[index].id, type),
                  onTap: () => _onItemTap(safeItems[index], context),
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

  int _getColorCode(String? color, int index) {
    if (type == FavoriteItemType.teacher) {
      var colors = ColorUtils.getTeachersColorsCodes();
      return colors[index % colors.length];
    } else {
      return int.parse(color ?? '0xFFFFFFFF');
    }
  }

  void _onItemTap(FavoriteObject item, BuildContext context) {
    if (type == FavoriteItemType.subject && item is FavoriteSubject) {
      if (item.subjects != null && item.subjects!.isNotEmpty) {
        _showModalSheet(item, context);
      } else {
        BlocProvider.of<FavoriteBloc>(context)
            .add(FavoriteSelectSubjectEvent(mainSubjectId: item.id));
      }
    } else {
      BlocProvider.of<FavoriteBloc>(context).add(FavoriteSelectTeacherEvent(item.id));
    }
  }

  void _showModalSheet(FavoriteSubject item, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (ctx) {
        return BlocProvider.value(
          value: BlocProvider.of<FavoriteBloc>(context),
          child: FavoriteSubjectsModalSheet(
            item: item,
            onSubSubjectTapped: (String subSubjectId) {
              BlocProvider.of<FavoriteBloc>(context).add(
                FavoriteSelectSubjectEvent(
                  mainSubjectId: item.id,
                  subSubjectId: subSubjectId,
                ),
              );
            },
            onSelectAllTapped: () {
              BlocProvider.of<FavoriteBloc>(context).add(
                FavoriteSelectSubjectEvent(
                  mainSubjectId: item.id,
                  selectAll: true,
                ),
              );
            },
            onOkButtonTapped: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
