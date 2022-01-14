import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/signup_remote_provider.dart';

class SignUpRepo extends BaseRepo {
  SignUpRepo()
      : _signUpRemoteProvider = SignUpRemoteProvider(),
        super();

  final SignUpRemoteProvider _signUpRemoteProvider;

  Future<String?> signUpUser({
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
      return _signUpRemoteProvider.signUpInitiate(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        birthdayDate: birthdayDate,
        password: password,
        country: country,
      );
    } on Exception catch (e) {
      throw e;
    }
  }

  // Future<String?> verifyPhoneNumber(String phoneNumber) {
  //   try {
  //     return _signUpRemoteProvider.verifyPhoneNumberInitiate(phoneNumber);
  //   } on Exception catch (e) {
  //     throw e;
  //   }
  // }
}
