part of 'my_surveys_bloc.dart';

enum MySurveyScreenStatus {
  loading,
  loaded,
  loadFailed,
}

class MySurveysState extends BaseBlocState {
  final MySurveyScreenStatus? status;
  final List<Survey> mySurveyList;

  MySurveysState({
    this.status,
    required this.mySurveyList,
  });

  MySurveysState.init()
      : this.mySurveyList = [],
        this.status = MySurveyScreenStatus.loading;

  MySurveysState copyWith({
    List<Survey>? newSurveyList,
    MySurveyScreenStatus? status,
  }) {
    return MySurveysState(
      mySurveyList: newSurveyList ?? this.mySurveyList,
      status: status ?? this.status,
    );
  }

  bool isSurveysEmpty() {
    return mySurveyList.isEmpty && status != MySurveyScreenStatus.loading;
  }

  @override
  List<Object?> get props => [status, mySurveyList];
}
