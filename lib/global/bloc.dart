import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v24_student_app/feature/favorite/bloc/favorite_bloc.dart';
import 'package:v24_student_app/feature/login/bloc/login_bloc.dart';
import 'package:v24_student_app/feature/signup/additonal_credentials/bloc/sign_up_additional_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/credentials/bloc/signup_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/sms_code/bloc/signup_code_bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/repo/favorites_repo.dart';
import 'package:v24_student_app/repo/sign_in_repo.dart';
import 'package:v24_student_app/repo/sign_up_repo.dart';

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
    return LoginBloc(authBloc: authBloc, signInRepo: SignInRepo());
  }

  SignUpCredentialsBloc createSignUpCredentialsBloc() {
    return SignUpCredentialsBloc();
  }

  SignUpAdditionalCredentialsBloc createSignUpAdditionalCredentialsBloc() {
    return SignUpAdditionalCredentialsBloc(authBloc: authBloc, signUpRepo: SignUpRepo());
  }

  SignUpCodeBloc createSignUpCodeBloc(String phoneValue) {
    return SignUpCodeBloc(authBloc: authBloc, signUpRepo: SignUpRepo(), phoneNumber: phoneValue);
  }

  FavoriteBloc createFavoriteBloc() {
    return FavoriteBloc(favoriteRepo: FavoriteRepo());
  }
}
