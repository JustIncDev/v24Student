import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/signup_remote_provider.dart';

class SignUpRepo extends BaseRepo {
  SignUpRepo()
      : _signUpRemoteProvider = SignUpRemoteProvider(),
        super();

  final SignUpRemoteProvider _signUpRemoteProvider;
}
