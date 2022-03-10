import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v24_student_app/feature/favorite/bloc/favorite_bloc.dart';
import 'package:v24_student_app/feature/login/bloc/login_bloc.dart';
import 'package:v24_student_app/feature/pin/bloc/pin_bloc.dart';
import 'package:v24_student_app/feature/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:v24_student_app/feature/settings/bloc/settings_bloc.dart';
import 'package:v24_student_app/feature/signup/additonal_credentials/bloc/sign_up_additional_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/credentials/bloc/signup_credentials_bloc.dart';
import 'package:v24_student_app/feature/signup/sms_code/bloc/signup_code_bloc.dart';
import 'package:v24_student_app/feature/surveys/all_surveys/bloc/surveys_bloc.dart';
import 'package:v24_student_app/feature/surveys/my_surveys/bloc/my_surveys_bloc.dart';
import 'package:v24_student_app/feature/surveys/survey/bloc/survey_bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/repo/favorites_repo.dart';
import 'package:v24_student_app/repo/file_repo.dart';
import 'package:v24_student_app/repo/profile_repo.dart';
import 'package:v24_student_app/repo/sign_in_repo.dart';
import 'package:v24_student_app/repo/sign_up_repo.dart';
import 'package:v24_student_app/repo/surveys_repo.dart';

import 'data_blocs/profile/owner_profile_bloc.dart';

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

///Bloc factory for creating feature blocs
class BlocFactory {
  BlocFactory({
    required this.authBloc,
  }) {
    var profileRepo = ProfileRepo();
    _ownerProfileBloc = OwnerProfileBloc(profileRepo: profileRepo);
  }

  final AuthBloc authBloc;

  late OwnerProfileBloc _ownerProfileBloc;

  OwnerProfileBloc get ownerProfileBloc => _ownerProfileBloc;

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

  PinBloc createPinBloc(bool? enterScreen) {
    return PinBloc(authBloc: authBloc, enterScreen: enterScreen ?? false);
  }

  SurveysBloc createSurveysBloc() {
    return SurveysBloc(surveysRepo: SurveysRepo());
  }

  SurveyBloc createSurveyBloc(String surveyId, bool? answeredSurvey) {
    return SurveyBloc(
      surveysRepo: SurveysRepo(),
      surveyId: surveyId,
      answeredSurvey: answeredSurvey ?? false,
    );
  }

  MySurveysBloc createMySurveysBloc() {
    return MySurveysBloc(surveysRepo: SurveysRepo());
  }

  SettingsBloc createSettingsBloc() {
    return SettingsBloc();
  }

  EditProfileBloc createEditProfileBloc() {
    return EditProfileBloc(
      fileRepo: FileRepo(),
      profileBloc: ownerProfileBloc,
      profileRepo: ProfileRepo(),
    );
  }
}
