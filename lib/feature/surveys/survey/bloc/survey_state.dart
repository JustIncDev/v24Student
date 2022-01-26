part of 'survey_bloc.dart';

class SurveyState extends BaseBlocState {
  final BaseScreenStatus? status;
  final List<Question> questions;
  final Map<String, Answer> answersMap;

  SurveyState({
    this.status,
    required this.questions,
    required this.answersMap,
  });

  SurveyState.init()
      : this.status = BaseScreenStatus.lock,
        this.questions = [],
        this.answersMap = {};

  SurveyState copyWith({
    List<Question>? questions,
    Map<String, Answer>? answersMap,
    BaseScreenStatus? status,
  }) {
    return SurveyState(
      questions: questions ?? this.questions,
      answersMap: answersMap ?? this.answersMap,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, questions, answersMap];
}
