import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/feature/favorite/bloc/favorite_bloc.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_grid_widget.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_item_widget.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

typedef OnSubSubjectTapped = void Function(String subSubjectId);

class FavoriteSubjectsModalSheet extends StatelessWidget {
  const FavoriteSubjectsModalSheet({
    Key? key,
    required this.item,
    this.onSubSubjectTapped,
    this.onSelectAllTapped,
    this.onOkButtonTapped,
  }) : super(key: key);

  final FavoriteSubject item;
  final OnSubSubjectTapped? onSubSubjectTapped;
  final VoidCallback? onSelectAllTapped;
  final VoidCallback? onOkButtonTapped;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const VerticalSpace(10.0),
                Container(
                  width: 40.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                const VerticalSpace(18.0),
                IntrinsicHeight(
                  child: FavoriteItemWidget(
                    title: item.title,
                    iconPath: item.imagePath ?? '',
                    backgroundColor: int.parse(item.color ?? '0xFFFFFFFF'),
                    itemType: FavoriteItemType.subject,
                    selected: false,
                    bottomSheet: true,
                  ),
                ),
                const VerticalSpace(10.0),
                Text(
                  getStringById(context, StringId.selectSubjects),
                  style: TextStyle(
                    color: AppColors.black.withOpacity(0.4),
                    fontSize: 12.0,
                    letterSpacing: -0.3,
                  ).montserrat(fontWeight: AppFonts.semiBold),
                ),
                const VerticalSpace(18.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppColors.disabledColor),
                  ),
                  child: ListView.builder(
                    itemCount: item.subjects?.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.5),
                              child: GestureDetector(
                                onTap: () => onSubSubjectTapped?.call(item.subjects![index].id),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.subjects![index].subject,
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                          color: AppColors.black,
                                        ).montserrat(fontWeight: AppFonts.regular),
                                      ),
                                    ),
                                    if (state.isSubSubjectSelected(
                                        item.id, item.subjects![index].id))
                                      SvgPicture.asset(AppIcons.selectIcon),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: index == item.subjects!.length - 1
                                ? AppColors.transparent
                                : AppColors.black.withOpacity(0.06),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const VerticalSpace(18.0),
                TextButton(
                  onPressed: onSelectAllTapped,
                  child: Text(
                    getStringById(context, StringId.selectAllSubjects),
                    style: const TextStyle(
                      color: AppColors.royalBlue,
                      fontSize: 13.0,
                    ).montserrat(fontWeight: AppFonts.semiBold),
                  ),
                ),
                const VerticalSpace(18.0),
                PrimaryButton(
                  titleId: StringId.ok,
                  onPressed: onOkButtonTapped,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
