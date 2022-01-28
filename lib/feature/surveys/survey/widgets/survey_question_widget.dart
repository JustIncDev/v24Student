import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/feature/surveys/survey/bloc/survey_bloc.dart';
import 'package:v24_student_app/global/ui/text_field/app_text_field.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

class SurveyQuestionWidget extends StatefulWidget {
  const SurveyQuestionWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  State<SurveyQuestionWidget> createState() => _SurveyQuestionWidgetState();
}

class _SurveyQuestionWidgetState extends State<SurveyQuestionWidget> {
  late TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController?.addListener(
      () {
        BlocProvider.of<SurveyBloc>(context).add(
          SurveyInputQuestionEvent(widget.question.id, _textEditingController?.text),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<SurveyBloc>(context).state;
    _updateController(state);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.royalBlue.withOpacity(0.1),
                blurRadius: 20.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.question.question,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 13.0,
                    letterSpacing: -0.3,
                  ).montserrat(fontWeight: AppFonts.semiBold),
                  textAlign: TextAlign.center,
                ),
              ),
              AppTextField(
                controller: _textEditingController,
                textAlign: TextAlign.left,
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateController(SurveyState state) {
    var answer = state.answersMap[widget.question.id];
    if (_textEditingController?.text != answer && answer != null) {
      _textEditingController?.text = answer;
    }
  }
}
