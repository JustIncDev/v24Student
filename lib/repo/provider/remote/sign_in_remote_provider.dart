import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/user_profile.dart';
import 'package:v24_student_app/global/ui/button/social_button.dart';
import 'package:v24_student_app/utils/text.dart';

class SignInRemoteProvider {
  SignInRemoteProvider();

  Future<String?> loginWithEmail(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value.user!.uid;
      });
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      var loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        var accessToken = loginResult.accessToken;
        var facebookAuthCredential = FacebookAuthProvider.credential(accessToken?.token ?? '');
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential)
            .then((value) => _authenticateUser(value, SocialMediaType.facebook));
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<String?> signInWithApple() async {
    try {
      final rawNonce = TextUtils.generateNonce();
      final nonce = TextUtils.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      return await FirebaseAuth.instance
          .signInWithCredential(oauthCredential)
          .then((value) => _authenticateUser(value, SocialMediaType.apple));
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<String?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => _authenticateUser(value, SocialMediaType.google));
  }

  Future<String?> _authenticateUser(
      UserCredential userCredential, SocialMediaType socialMediaType) async {
    if ((userCredential.additionalUserInfo?.isNewUser ?? false)) {
      var userModel = UserProfile(
        id: userCredential.user?.uid ?? '',
        firstName: userCredential.additionalUserInfo?.profile?[
                socialMediaType != SocialMediaType.google ? 'first_name' : 'given_name'] ??
            '',
        lastName: userCredential.additionalUserInfo?.profile?[
                socialMediaType != SocialMediaType.google ? 'last_name' : 'family_name'] ??
            '',
        firebaseEmail: FirebaseEmail(userCredential.user?.email ?? '', false),
        firebasePhone: FirebasePhone(userCredential.user?.phoneNumber ?? '', false),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());
    }
    return userCredential.user!.uid;
  }
}
