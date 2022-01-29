import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/feature/surveys/all_surveys/widgets/survey_item_widget.dart';
import 'package:v24_student_app/feature/surveys/my_surveys/bloc/my_surveys_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/child_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/placeholders/large_placeholder.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

class MySurveysScreen extends StatefulWidget {
  const MySurveysScreen({Key? key}) : super(key: key);

  @override
  _MySurveysScreenState createState() => _MySurveysScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('my_surveys'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createMySurveysBloc();
        },
        child: const MySurveysScreen(),
        lazy: false,
      ),
    );
  }
}

class _MySurveysScreenState extends State<MySurveysScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySurveysBloc, MySurveysState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const VerticalSpace(58.5),
                          Center(
                            child: Text(
                              getStringById(context, StringId.mySurveys),
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                letterSpacing: -0.3,
                              ).montserrat(fontWeight: AppFonts.semiBold),
                            ),
                          ),
                          if (state.isSurveysEmpty())
                            const Flexible(
                              child: LargePlaceholder(
                                titleId: StringId.noSurveys,
                                descriptionId: StringId.noMySurveysDescription,
                              ),
                            )
                          else
                            Flexible(
                              child: ListView.builder(
                                itemCount: state.mySurveyList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => _onSurveyItemTap(state.mySurveyList[index]),
                                    child: SurveyItemWidget(
                                      item: state.mySurveyList[index],
                                      answeredSurvey: true,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            state.status == MySurveyScreenStatus.loading ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }

  void _onSurveyItemTap(Survey item) {
    ChildRouter.of(context)
        ?.push(
      ScreenInfo.withResult(
        name: ScreenName.survey,
        params: {
          'survey': item,
          'answeredSurvey': true,
        },
      ),
    )
        .then((_) {
      BlocProvider.of<MySurveysBloc>(context).add(MySurveysUpdateEvent());
    });
  }
}
