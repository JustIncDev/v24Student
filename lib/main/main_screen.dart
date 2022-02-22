import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/child_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/utils/device.dart';
import 'package:v24_student_app/utils/ui.dart';

class MainScreenScope extends InheritedWidget {
  const MainScreenScope({
    Key? key,
    required this.state,
    required this.activePageIndex,
    required Widget child,
  }) : super(key: key, child: child);

  final _MainScreenState state;
  final int activePageIndex;

  @override
  bool updateShouldNotify(covariant MainScreenScope oldWidget) {
    return this.activePageIndex != oldWidget.activePageIndex;
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.rootBackButtonDispatcher}) : super(key: key);

  final RootBackButtonDispatcher rootBackButtonDispatcher;

  static Page<void> buildPage({
    required RootBackButtonDispatcher backDispatcher,
    required BlocFactory blocFactory,
  }) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('main'),
      child: MainScreen(rootBackButtonDispatcher: backDispatcher),
    );
  }

  @override
  _MainScreenState createState() => _MainScreenState();

  static _MainScreenState? of(BuildContext context, {bool register = false}) {
    if (register) {
      return context.dependOnInheritedWidgetOfExactType<MainScreenScope>()?.state;
    } else {
      return (context.getElementForInheritedWidgetOfExactType<MainScreenScope>()?.widget
              as MainScreenScope?)
          ?.state;
    }
  }
}

class _MainScreenState extends State<MainScreen> {
  // ignore: prefer_final_fields
  int _selectedPageIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ChildBackButtonDispatcher _settingsBBDispatcher;
  late ChildBackButtonDispatcher _surveysBBDispatcher;
  late ChildBackButtonDispatcher _mySurveysBBDispatcher;
  late ChildBackButtonDispatcher _myProfileBBDispatcher;

  int get selectedPageIndex => _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _settingsBBDispatcher = ChildBackButtonDispatcher(widget.rootBackButtonDispatcher);
    _surveysBBDispatcher = ChildBackButtonDispatcher(widget.rootBackButtonDispatcher);
    _mySurveysBBDispatcher = ChildBackButtonDispatcher(widget.rootBackButtonDispatcher);
    _myProfileBBDispatcher = ChildBackButtonDispatcher(widget.rootBackButtonDispatcher);
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenScope(
      state: this,
      activePageIndex: this._selectedPageIndex,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.blueRaspberry,
                AppColors.hooloovooBlue,
                AppColors.sixteenMillionPink,
              ],
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedPageIndex,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            backgroundColor: AppColors.transparent,
            fixedColor: AppColors.transparent,
            onTap: selectIndex,
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            selectedLabelStyle: const TextStyle(fontSize: 0),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 50.0,
                  height: DeviceUtils.isDeviceWithStroke(context) ? 50.0 : 71.0,
                  child: Column(
                    children: [
                      const VerticalSpace(15.0),
                      SvgPicture.asset(AppIcons.settingsIcon),
                      if (_selectedPageIndex == 0) const _NavigationPointWidget(),
                    ],
                  ),
                ),
                label: 'settings',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 50.0,
                  height: DeviceUtils.isDeviceWithStroke(context) ? 50.0 : 71.0,
                  child: Column(
                    children: [
                      const VerticalSpace(15.0),
                      SvgPicture.asset(AppIcons.surveysIcon),
                      if (_selectedPageIndex == 1) const _NavigationPointWidget(),
                    ],
                  ),
                ),
                label: 'all_surveys',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 50.0,
                  height: DeviceUtils.isDeviceWithStroke(context) ? 50.0 : 71.0,
                  child: Column(
                    children: [
                      const VerticalSpace(15.0),
                      SvgPicture.asset(AppIcons.mySurveysIcon),
                      if (_selectedPageIndex == 2) const _NavigationPointWidget(),
                    ],
                  ),
                ),
                label: 'my_surveys',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 50.0,
                  height: DeviceUtils.isDeviceWithStroke(context) ? 50.0 : 71.0,
                  child: Column(
                    children: [
                      const VerticalSpace(15.0),
                      SvgPicture.asset(AppIcons.myProfileIcon),
                      if (_selectedPageIndex == 3) const _NavigationPointWidget(),
                    ],
                  ),
                ),
                label: 'my_profile',
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: _selectedPageIndex,
              children: [
                ChildRouter(
                  name: 'settings',
                  initScreenInfo: const ScreenInfo(name: ScreenName.settings),
                  backButtonDispatcher: _selectedPageIndex == 0 ? _settingsBBDispatcher : null,
                ),
                ChildRouter(
                  name: 'all_surveys',
                  initScreenInfo: const ScreenInfo(name: ScreenName.surveys),
                  backButtonDispatcher: _selectedPageIndex == 1 ? _surveysBBDispatcher : null,
                ),
                ChildRouter(
                  name: 'my_surveys',
                  initScreenInfo: const ScreenInfo(name: ScreenName.mySurveys),
                  backButtonDispatcher: _selectedPageIndex == 2 ? _mySurveysBBDispatcher : null,
                ),
                ChildRouter(
                  name: 'my_profile',
                  initScreenInfo: const ScreenInfo(name: ScreenName.profile),
                  backButtonDispatcher: _selectedPageIndex == 3 ? _myProfileBBDispatcher : null,
                ),
              ],
            ),
            // state ? const ProgressWall(progressWallType: ProgressWallType.dark) : const Offstage(),
          ],
        ),
      ),
    );
  }

  void selectIndex(int index) {
    setState(() {
      if (_selectedPageIndex != index) {
        _selectedPageIndex = index;
      }
    });
  }
}

class _NavigationPointWidget extends StatelessWidget {
  const _NavigationPointWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
      ),
    );
  }
}
