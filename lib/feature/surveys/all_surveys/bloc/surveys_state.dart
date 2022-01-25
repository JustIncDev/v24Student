part of 'surveys_bloc.dart';

enum SurveyScreenStatus {
  loading,
  loaded,
  loadFailed,
}

class SurveysState extends BaseBlocState {
  final SurveyScreenStatus? status;
  final List<Survey> surveyList;

  SurveysState({
    this.status,
    required this.surveyList,
  });

  SurveysState.init()
      : this.surveyList = [],
        this.status = SurveyScreenStatus.loading;

  SurveysState copyWith({
    List<Survey>? surveyList,
    SurveyScreenStatus? status,
  }) {
    return SurveysState(
      surveyList: surveyList ?? this.surveyList,
      status: status ?? this.status,
    );
  }

  bool isSurveysEmpty() {
    return surveyList.isEmpty && status != SurveyScreenStatus.loading;
  }

  @override
  List<Object?> get props => [status, surveyList];
}
