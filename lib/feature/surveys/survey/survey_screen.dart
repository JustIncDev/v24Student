import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/feature/surveys/survey/bloc/survey_bloc.dart';
import 'package:v24_student_app/feature/surveys/survey/widgets/survey_container_widget.dart';
import 'package:v24_student_app/feature/surveys/survey/widgets/survey_question_widget.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/child_router.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({
    Key? key,
    required this.survey,
    required this.answeredSurvey,
  }) : super(key: key);

  final Survey survey;
  final bool answeredSurvey;

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    late Survey survey;
    late bool answeredSurvey;
    if (params != null) {
      survey = params['survey'] as Survey;
      answeredSurvey = (params['answeredSurvey'] as bool?) ?? false;
    }

    return UiUtils.createPlatformPage(
      key: const ValueKey('survey'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSurveyBloc(
            survey.id,
            answeredSurvey,
          );
        },
        child: SurveyScreen(
          survey: survey,
          answeredSurvey: answeredSurvey,
        ),
        lazy: false,
      ),
    );
  }
}

class _SurveyScreenState extends State<SurveyScreen> {
  // ignore: prefer_final_fields
  int _currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurveyBloc, SurveyState>(
      listenWhen: (previous, current) {
        return (previous.status != current.status && current.status == BaseScreenStatus.back);
      },
      listener: (context, state) {
        if (state.status == BaseScreenStatus.back) {
          ChildRouter.of(context)?.pop();
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VerticalSpace(15.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        AppIcons.arrowLeftIcon,
                                        color: AppColors.black,
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      iconSize: 18.0,
                                      onPressed: _onBackButtonPressed,
                                    ),
                                    Center(
                                      child: Text(
                                        getStringById(
                                          context,
                                          widget.answeredSurvey
                                              ? StringId.answeredSurvey
                                              : StringId.survey,
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
                                const VerticalSpace(24.5),
                                SurveyContainerWidget(
                                  item: widget.survey,
                                  answeredSurvey: widget.answeredSurvey,
                                ),
                                const VerticalSpace(28.0),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.questions),
                                    style: const TextStyle(
                                      color: AppColors.royalBlue,
                                      fontSize: 14.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    state.questions.length,
                                    (index) => buildDot(index: index),
                                  ),
                                ),
                                const VerticalSpace(14.0),
                                Flexible(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    child: PageView(
                                      onPageChanged: (value) {
                                        setState(() {
                                          _currentQuestion = value;
                                        });
                                      },
                                      controller: PageController(
                                        viewportFraction: 0.9,
                                        initialPage: 0,
                                      ),
                                      children: List.generate(state.questions.length, (index) {
                                        return SurveyQuestionWidget(
                                          question: state.questions[index],
                                          answeredSurvey: widget.answeredSurvey,
                                          answerList: state.answeredList,
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (!widget.answeredSurvey)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: PrimaryButton(
                                      titleId: StringId.submitAnswers,
                                      onPressed:
                                          state.isAllQuestionsAnswered() ? _submitAnswersTap : null,
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
            state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }

  void _onBackButtonPressed() {
    ChildRouter.of(context)?.pop();
  }

  void _submitAnswersTap() {
    BlocProvider.of<SurveyBloc>(context).add(SurveySubmitAnswersPerformEvent());
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 6,
      width: _currentQuestion == index ? 24 : 6,
      decoration: BoxDecoration(
        color: _currentQuestion == index ? AppColors.royalBlue : AppColors.disabledColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
