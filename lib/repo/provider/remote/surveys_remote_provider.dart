import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/domain/answer.dart';
import 'package:v24_student_app/domain/question.dart';
import 'package:v24_student_app/domain/survey.dart';

class SurveysRemoteProvider {
  SurveysRemoteProvider();

  Future<List<Survey>?> getAllSurveys() async {
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

  Future<List<Survey>?> getMySurveys() async {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((currentUser) async {
        var surveys = currentUser.get('surveys');
        return FirebaseFirestore.instance
            .collection('surveys')
            .where(FieldPath.documentId, whereIn: surveys)
            .get()
            .then((response) {
          var itemList = <Survey>[];
          for (final element in response.docs) {
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

  Future<List<Question>> getQuestionList(String surveyId) async {
    try {
      return FirebaseFirestore.instance
          .collection('surveys')
          .doc(surveyId)
          .collection('questions')
          .orderBy('index')
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

  Future<Answer> getUserAnswer(String questionId, String surveyId) async {
    return FirebaseFirestore.instance
        .collection('surveys')
        .doc(surveyId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .where('author.id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((answers) async {
      var answer = answers.docs.first;
      var dataMap = <String, Object?>{
        'id': answer.id,
      };
      dataMap.addAll(answer.data());
      return Answer.fromJson(dataMap);
    });
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
              'id': currentUser.id,
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
