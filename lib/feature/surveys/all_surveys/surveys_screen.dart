import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/surveys_bloc.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  _SurveysScreenState createState() => _SurveysScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('all_surveys'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSurveysBloc();
        },
        child: const SurveysScreen(),
        lazy: false,
      ),
    );
  }
}

class _SurveysScreenState extends State<SurveysScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurveysBloc, SurveysState>(
      listenWhen: (previous, current) {
        // return (previous.needFocusField != current.needFocusField) ||
        //     (previous.status != current.status && current.status == BaseScreenStatus.next);
        return false;
      },
      listener: (context, state) {
        // if (state.status == BaseScreenStatus.next) {
        //   RootRouter.of(context)?.push(ScreenInfo(name: ScreenName.signUpAdditional, params: {
        //     'firstName': state.firstNameValue,
        //     'lastName': state.lastNameValue,
        //     'email': state.emailValue,
        //     'phoneNumber': state.phoneValue,
        //     'country': state.countryNameValue,
        //     'password': state.passwordValue,
        //   }));
        // }
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VerticalSpace(58.5),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.surveys),
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(24.5),
                                Spacer(),
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
            // state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }
}
