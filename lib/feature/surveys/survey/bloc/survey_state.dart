part of 'survey_bloc.dart';

class SurveyState extends BaseBlocState {
  final BaseScreenStatus? status;
  final List<Question> questions;
  final Map<String, String> answersMap;
  final List<Answer> answeredList;

  SurveyState({
    this.status,
    required this.questions,
    required this.answersMap,
    required this.answeredList,
  });

  SurveyState.init()
      : this.status = BaseScreenStatus.lock,
        this.questions = [],
        this.answersMap = {},
        this.answeredList = [];

  SurveyState copyWith({
    List<Question>? questions,
    Map<String, String>? answersMap,
    BaseScreenStatus? status,
    List<Answer>? answeredList,
  }) {
    return SurveyState(
      questions: questions ?? this.questions,
      answersMap: answersMap ?? this.answersMap,
      status: status ?? this.status,
      answeredList: answeredList ?? this.answeredList,
    );
  }

  bool isAllQuestionsAnswered() {
    return questions.length == answersMap.length &&
        (answersMap.values.where((element) => element.isEmpty)).isEmpty &&
        status == BaseScreenStatus.input;
  }

  @override
  List<Object?> get props => [status, questions, answersMap, answeredList];
}
