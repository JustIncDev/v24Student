import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/sign_in_remote_provider.dart';

class SignInRepo extends BaseRepo {
  SignInRepo()
      : _signInRemoteProvider = SignInRemoteProvider(),
        super();

  final SignInRemoteProvider _signInRemoteProvider;

  Future<String?> loginWithEmail({required String email, required String password}) {
    return _signInRemoteProvider.loginWithEmail(email, password);
  }

  Future<String?> signInWithFacebook() {
    return _signInRemoteProvider.signInWithFacebook();
  }

  Future<String?> signInWithApple() {
    return _signInRemoteProvider.signInWithApple();
  }

  Future<String?> signInWithGoogle() {
    return _signInRemoteProvider.signInWithGoogle();
  }
}
