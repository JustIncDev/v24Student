import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/user_profile.dart';

class SignUpRemoteProvider {
  SignUpRemoteProvider();

  Future<String?> signUpInitiate({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String birthdayDate,
    required String country,
    required String password,
  }) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var safeUser = userCredential.user;
      if (safeUser != null) {
        var userProfile = UserProfile(
          id: safeUser.uid,
          firstName: firstName,
          lastName: lastName,
          firebaseEmail: FirebaseEmail(email, false),
          firebasePhone: FirebasePhone(phoneNumber, false),
          country: country,
          gender: gender,
          birthdayDate: birthdayDate,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(safeUser.uid)
            .set(userProfile.toJson());
        return safeUser.uid;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
