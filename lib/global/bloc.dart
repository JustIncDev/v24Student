import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v24_student_app/feature/login/bloc/login_bloc.dart';
import 'package:v24_student_app/feature/signup/credentials/bloc/signup_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/sms_code/bloc/signup_code_bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';

abstract class BaseBlocEvent extends Equatable {
  @override
  bool get stringify => false;
}

abstract class BaseBlocState extends Equatable {}

enum BaseScreenStatus { input, lock, next, back }

abstract class DataBloc<E extends BaseBlocEvent, S extends BaseBlocState> extends Bloc<E, S> {
  DataBloc(S initState) : super(initState);

  Future<void> init();
}

class BlocFactory {
  BlocFactory({
    required this.authBloc,
  });

  final AuthBloc authBloc;

  LoginBloc createLoginBloc() {
    return LoginBloc(
        // authBloc: authBloc,
        );
  }

  SignUpCredentialsBloc createSignUpCredentialsBloc() {
    return SignUpCredentialsBloc(
        // signUpRepo: SignUpRepo(api: remoteApi),
        );
  }

  SignUpCodeBloc createSignUpCodeBloc() {
    return SignUpCodeBloc();
  }
}
