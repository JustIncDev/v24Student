part of 'survey_bloc.dart';

abstract class SurveyEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class SurveyInitEvent extends SurveyEvent {
  final String surveyId;
  final bool answeredSurvey;

  SurveyInitEvent(this.surveyId, this.answeredSurvey);
}

class SurveyInputQuestionEvent extends SurveyEvent {
  final String questionId;
  final String? value;

  SurveyInputQuestionEvent(this.questionId, this.value);

  @override
  List<Object?> get props => [value];
}

class SurveySubmitAnswersPerformEvent extends SurveyEvent {}

class SurveySuccessEvent extends SurveyEvent {}

class SurveyFailedEvent extends SurveyEvent {}
