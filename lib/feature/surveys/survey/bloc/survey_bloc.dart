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
  final String _surveyId;

  SurveyBloc({
    required SurveysRepo surveysRepo,
    required String surveyId,
    bool answeredSurvey = false,
  })  : _surveysRepo = surveysRepo,
        _surveyId = surveyId,
        super(SurveyState.init()) {
    on<SurveyEvent>((event, emit) async {
      if (event is SurveyInitEvent) {
        await _handleInitEvent(event, emit);
      } else if (event is SurveyInputQuestionEvent) {
        _handleInputQuestionEvent(event, emit);
      } else if (event is SurveySubmitAnswersPerformEvent) {
        await _handleSubmitAnswersPerformEvent(event, emit);
      }
    });
    add(SurveyInitEvent(surveyId, answeredSurvey));
  }

  Future<void> _handleInitEvent(
    SurveyInitEvent event,
    Emitter<SurveyState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    if (event.answeredSurvey) {
      var questions = await _surveysRepo.getQuestionList(event.surveyId);
      if (questions != null) {
        var answers = await _surveysRepo.getUserAnswers(event.surveyId, questions);
        emit(state.copyWith(
            answeredList: answers, questions: questions, status: BaseScreenStatus.input));
      }
    } else {
      var questions = await _surveysRepo.getQuestionList(event.surveyId);
      emit(state.copyWith(questions: questions, status: BaseScreenStatus.input));
    }
  }

  void _handleInputQuestionEvent(
    SurveyInputQuestionEvent event,
    Emitter<SurveyState> emit,
  ) {
    var newMap = <String, String>{};
    newMap.addAll(state.answersMap);
    newMap[event.questionId] = event.value ?? '';
    emit(state.copyWith(answersMap: newMap));
  }

  Future<void> _handleSubmitAnswersPerformEvent(
    SurveySubmitAnswersPerformEvent event,
    Emitter<SurveyState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    try {
      await _surveysRepo.submitAnswers(state.answersMap, _surveyId);
    } on Exception catch (e) {
      emit(state.copyWith(status: BaseScreenStatus.input));
    }
    emit(state.copyWith(status: BaseScreenStatus.back));
  }
}
