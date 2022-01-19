import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/domain/teacher.dart';

class FavoriteRemoteProvider {
  FavoriteRemoteProvider();

  Future<List<FavoriteSubject>> getMainSubjects() async {
    try {
      return FirebaseFirestore.instance.collection('mainSubjects').get().then((response) async {
        return response.docs.map((element) {
          var dataMap = <String, Object?>{
            'id': element.id,
          };
          dataMap.addAll(element.data());
          return FavoriteSubject.fromJson(dataMap);
        }).toList();
      });
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<FavoriteTeacher>> getTeachersList() async {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where('isTeacher', isEqualTo: true)
          .get()
          .then((response) {
        return response.docs.map((element) {
          var dataMap = <String, Object?>{
            'id': element.id,
            'imagePath': element.data()['profilePicture'],
            'title': (element.data()['firstName'] ?? 'Lorem') +
                ' ' +
                (element.data()['lastName'] ?? 'Ipsum'),
          };
          return FavoriteTeacher.fromJson(dataMap);
        }).toList();
      });
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<SubSubject>> getSubSubjectList(String mainSubjectId) async {
    return FirebaseFirestore.instance
        .collection('mainSubjects')
        .doc(mainSubjectId)
        .collection('subjects')
        .get()
        .then((response) {
      return response.docs.map((element) {
        var dataMap = <String, Object?>{
          'id': element.id,
        };
        dataMap.addAll(element.data());
        return SubSubject.fromJson(dataMap);
      }).toList();
    });
  }
}
