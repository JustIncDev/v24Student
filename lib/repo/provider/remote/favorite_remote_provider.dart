import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteRemoteProvider {
  FavoriteRemoteProvider();

  Future<void> getSubjectsList() async {
    try {
      var response = await FirebaseFirestore.instance.collection('MainSubjects').get();
      var ids = <String>[];
      response.docs.forEach((element) {
        ids.add(element.id);
      });
      ids.forEach((element) {
        FirebaseFirestore.instance
            .collection('MainSubjects')
            .doc(element)
            .collection('subjects')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            print(element);
          });
        });
      });
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> getTeachersList() async {
    try {
      var response = await FirebaseFirestore.instance.collection('users').get();
    } on Exception catch (e) {
      throw e;
    }
  }
}
