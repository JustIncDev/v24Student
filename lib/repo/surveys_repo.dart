import 'package:v24_student_app/domain/answer.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/repo/base_repo.dart';

import 'provider/remote/surveys_remote_provider.dart';

///Repo for surveys
class SurveysRepo extends BaseRepo {
  SurveysRepo()
      : _surveysRemoteProvider = SurveysRemoteProvider(),
        super();

  final SurveysRemoteProvider _surveysRemoteProvider;

  Future<List<Survey>?> getAllSurveys() async {
    return _surveysRemoteProvider.getAllSurveys();
  }

  Future<List<Survey>?> getMySurveys() async {
    return _surveysRemoteProvider.getMySurveys();
  }

  Future<List<Question>?> getQuestionList(String surveyId) async {
    return _surveysRemoteProvider.getQuestionList(surveyId);
  }

  Future<List<Answer>> getUserAnswers(String surveyId, List<Question> questions) async {
    try {
      var answers = <Answer>[];
      for (var question in questions) {
        var answer = await _surveysRemoteProvider.getUserAnswer(question.id, surveyId);
        answers.add(answer);
      }
      return answers;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> submitAnswers(Map<String, String> answers, String surveyId) {
    return _surveysRemoteProvider.submitAnswers(answers, surveyId);
  }
}
