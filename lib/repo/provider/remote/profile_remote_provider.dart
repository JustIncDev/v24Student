import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/domain/user_profile.dart';

class ProfileRemoteProvider {
  ProfileRemoteProvider();

  Future<UserProfile?> getUserProfile() async {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((response) async {
        var doc = response.docs.first;
        return UserProfile.fromJson(doc.data());
      });
    } on Exception catch (e) {
      throw e;
    }
  }
}
