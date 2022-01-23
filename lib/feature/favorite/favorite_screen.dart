import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_grid_widget.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/favorite_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('favorite'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createFavoriteBloc()..add(FavoriteInitEvent());
        },
        child: const FavoriteScreen(),
        lazy: false,
      ),
    );
  }
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listenWhen: (previous, current) {
        return (previous.status != current.status && current.status == FavoriteScreenStatus.next);
      },
      listener: (context, state) {
        if (state.status == FavoriteScreenStatus.next) {
          RootRouter.of(context)?.push(const ScreenInfo(name: ScreenName.pin));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VerticalSpace(58.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        AppIcons.arrowLeftIcon,
                                        color: _currentPage == 1
                                            ? AppColors.black
                                            : AppColors.transparent,
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      iconSize: 18.0,
                                      onPressed: _currentPage == 0 ? null : _onBackButtonPressed,
                                    ),
                                    Center(
                                      child: Text(
                                        getStringById(
                                          context,
                                          _currentPage == 0
                                              ? StringId.myFavoriteSubjects
                                              : StringId.myFavoriteTeachers,
                                        ),
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(AppIcons.arrowLeftIcon),
                                      onPressed: null,
                                      color: AppColors.transparent,
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    getStringById(
                                        context,
                                        _currentPage == 0
                                            ? StringId.selectSubjects
                                            : StringId.selectTeachers),
                                    style: const TextStyle(
                                      color: AppColors.black30,
                                      fontSize: 12.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.35,
                                    child: PageView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      onPageChanged: (value) {
                                        setState(() {
                                          _currentPage = value;
                                        });
                                      },
                                      controller: _pageController,
                                      children: [
                                        FavoriteGridWidget(
                                          type: FavoriteItemType.subject,
                                          favoriteItems: state.favoriteSubjects,
                                          selectedItems: state.selectedSubjects,
                                        ),
                                        FavoriteGridWidget(
                                          type: FavoriteItemType.teacher,
                                          favoriteItems: state.favoriteTeachers,
                                          selectedItems: state.selectedTeachers,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 15.0,
                                      sigmaY: 15.0,
                                    ),
                                    child: Container(
                                      color: AppColors.white.withOpacity(0.8),
                                      child: Column(
                                        children: [
                                          const VerticalSpace(20.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(
                                              2,
                                              (index) => buildDot(index: index),
                                            ),
                                          ),
                                          const VerticalSpace(20.0),
                                          PrimaryButton(
                                            titleId:
                                                _currentPage == 0 ? StringId.next : StringId.finish,
                                            onPressed: () => _onFinishButtonTap(state),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            state.status == FavoriteScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }

  void _onFinishButtonTap(FavoriteState state) {
    if (_currentPage == 0) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    } else {
      BlocProvider.of<FavoriteBloc>(context).add(FavoritePerformEvent());
    }
  }

  void _onBackButtonPressed() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  Container buildDot({int? index}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.royalBlue : AppColors.disabledColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
