import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/domain/survey.dart';

class SurveysRemoteProvider {
  SurveysRemoteProvider();

  Future<List<Survey>?> getSurveyList() async {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((currentUser) async {
        var surveys = currentUser.get('surveys');
        return FirebaseFirestore.instance
            .collection('surveys')
            .where('status', isEqualTo: 'Started')
            .get()
            .then((response) async {
          var itemList = <Survey>[];
          for (final element in response.docs) {
            if (surveys.contains(element.id)) {
              continue;
            }
            var dataMap = <String, Object?>{
              'id': element.id,
            };
            dataMap.addAll(element.data());
            itemList.add(Survey.fromJson(dataMap));
          }
          return itemList;
        });
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

  Future<void> submitAnswers(Map<String, String> answers, String surveyId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((currentUser) async {
        answers.forEach((key, value) async {
          await FirebaseFirestore.instance
              .collection('surveys')
              .doc(surveyId)
              .collection('questions')
              .doc(key)
              .collection('answers')
              .add({
            'answer': value,
            'author': {
              'firstName': currentUser['firstName'],
              'lastName': currentUser['lastName'],
              'profilePicture': currentUser['profilePicture'],
            }
          });
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({
          'surveys': FieldValue.arrayUnion([surveyId])
        });
      });
    } on Exception catch (e) {
      throw e;
    }
  }
}
