import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/domain/survey.dart';

class SurveysRemoteProvider {
  SurveysRemoteProvider();

  Future<List<Survey>?> getSurveyList() async {
    try {
      return FirebaseFirestore.instance
          .collection('surveys')
          .where('status', isEqualTo: 'Started')
          .get()
          .then((response) async {
        return response.docs.map((element) {
          var dataMap = <String, Object?>{
            'id': element.id,
          };
          dataMap.addAll(element.data());
          return Survey.fromJson(dataMap);
        }).toList();
      });
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<Question>?> getQuestionList(String surveyId) async {
    try {
      return FirebaseFirestore.instance
          .collection('surveys')
          .doc(surveyId)
          .collection('questions')
          .get()
          .then((response) async {
        return response.docs.map((element) {
          var dataMap = <String, Object?>{
            'id': element.id,
          };
          dataMap.addAll(element.data());
          return Question.fromJson(dataMap);
        }).toList();
      });
    } on Exception catch (e) {
      throw e;
    }
  }
}