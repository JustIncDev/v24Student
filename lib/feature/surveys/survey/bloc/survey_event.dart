part of 'survey_bloc.dart';

abstract class SurveyEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class SurveyInitEvent extends SurveyEvent {
  final String surveyId;

  SurveyInitEvent(this.surveyId);
}

class SurveyInputQuestionEvent extends SurveyEvent {
  final String questionId;
  final String? value;

  SurveyInputQuestionEvent(this.questionId, this.value);

  @override
  List<Object?> get props => [value];
}

class SurveySuccessEvent extends SurveyEvent {}

class SurveyFailedEvent extends SurveyEvent {}