import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:v24_student_app/domain/answer.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/repo/surveys_repo.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveysRepo _surveysRepo;

  SurveyBloc({required SurveysRepo surveysRepo, required String surveyId})
      : _surveysRepo = surveysRepo,
        super(SurveyState.init()) {
    on<SurveyEvent>((event, emit) async {
      if (event is SurveyInitEvent) {
        await _handleInitEvent(event, emit);
      } else if (event is SurveyInputQuestionEvent) {
        _handleInputQuestionEvent(event, emit);
      }
    });
    add(SurveyInitEvent(surveyId));
  }

  Future<void> _handleInitEvent(
    SurveyInitEvent event,
    Emitter<SurveyState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    var questions = await _surveysRepo.getQuestionList(event.surveyId);
    emit(state.copyWith(questions: questions, status: BaseScreenStatus.input));
  }

  void _handleInputQuestionEvent(
    SurveyInputQuestionEvent event,
    Emitter<SurveyState> emit,
  ) {}
}
