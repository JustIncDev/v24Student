import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/login/bloc/login_bloc.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/images.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

import 'onboarding_content.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingWidget> {
  late PageController _pageController;

  Duration pageTurnDuration = const Duration(milliseconds: 200);

  int currentPage = 0;
  bool onboardingClosed = false;
  List<Map<String, Object>> onboardingData = [
    {
      'title': StringId.find,
      'description': StringId.onboarding1,
      'image': AppImages.firstOnboardingAsset,
    },
    {
      'title': StringId.participate,
      'description': StringId.onboarding2,
      'image': AppImages.secondOnboardingAsset,
    },
    {
      'title': StringId.explore,
      'description': StringId.onboarding3,
      'image': AppImages.thirdOnboardingAsset,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColors(),
                stops: [0.0, 0.61, 1.0],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpace(40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                const VerticalSpace(70.5),
                Flexible(
                  child: GestureDetector(
                    onHorizontalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Page forwards
                        _goForward();
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Page backwards
                        _goBack();
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        children: [
                          OnboardingContent(
                            title: onboardingData[0]['title'] as StringId,
                            description: onboardingData[0]['description'] as StringId,
                            image: onboardingData[0]['image'] as ImageProvider,
                          ),
                          OnboardingContent(
                            title: onboardingData[1]['title'] as StringId,
                            description: onboardingData[1]['description'] as StringId,
                            image: onboardingData[1]['image'] as ImageProvider,
                          ),
                          OnboardingContent(
                            title: onboardingData[2]['title'] as StringId,
                            description: onboardingData[2]['description'] as StringId,
                            image: onboardingData[2]['image'] as ImageProvider,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _goForward() {
    if (currentPage == 2) {
      BlocProvider.of<LoginBloc>(context).add(LoginCloseOnboardingEvent());
    } else {
      _pageController.nextPage(duration: pageTurnDuration, curve: Curves.easeIn);
    }
  }

  void _goBack() {
    _pageController.previousPage(duration: pageTurnDuration, curve: Curves.easeInOut);
  }

  List<Color> _getGradientColors() {
    return [
      AppColors.sixteenMillionPink,
      AppColors.hooloovooBlue,
      AppColors.blueRaspberry,
    ];
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.white : AppColors.borderColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
