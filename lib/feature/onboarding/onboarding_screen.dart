import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/screen.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/images.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/session_state.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'onboarding_content.dart';

class OnboardingScreen extends AppScreen {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();

  static Page buildPage({Map<String, Object>? params}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('onboarding'),
      child: const OnboardingScreen(),
    );
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  List<Map<String, Object>> onboardingData = [
    {
      'title': StringId.create,
      'description': StringId.onboarding1,
      'image': AppImages.firstOnboardingAsset,
    },
    {
      'title': StringId.manage,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColors(),
                stops: [0.0, 0.61, 1.0],
                // transform: const GradientRotation(2.3),
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
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                        if (value == 3) {
                          RootRouter.of(context)?.push(const ScreenInfo(name: ScreenName.login));
                          SessionState().setOnboardingFlag(true);
                        }
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
                        const Offstage(),
                      ],
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
