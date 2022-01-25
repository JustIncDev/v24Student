import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/repo/base_repo.dart';

import 'provider/remote/surveys_remote_provider.dart';

class SurveysRepo extends BaseRepo {
  SurveysRepo()
      : _surveysRemoteProvider = SurveysRemoteProvider(),
        super();

  final SurveysRemoteProvider _surveysRemoteProvider;

  Future<List<Survey>?> getSurveyList() async {
    return _surveysRemoteProvider.getSurveyList();
  }
}
