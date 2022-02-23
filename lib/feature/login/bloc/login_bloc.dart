import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';
import 'package:v24_student_app/global/ui/text_field/input_field_type.dart';
import 'package:v24_student_app/repo/sign_in_repo.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/session_state.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInRepo _signInRepo;
  final AuthBloc _authBloc;

  LoginBloc({
    required SignInRepo signInRepo,
    required AuthBloc authBloc,
  })  : _signInRepo = signInRepo,
        _authBloc = authBloc,
        super(LoginState(showOnboarding: !SessionState().getOnboardingFlag())) {
    on<LoginEvent>((event, emit) {
      if (event is LoginFieldInputEvent) {
        _handleInputEvent(event, emit);
      } else if (event is LoginFieldValidateEvent) {
        _handleValidateEvent(event, emit);
      } else if (event is LoginWithEmailPerformEvent) {
        _handlePerformEvent(event, emit);
      } else if (event is LoginWithFacebookPerformEvent) {
        _handleFacebookPerformEvent(event, emit);
      } else if (event is LoginWithApplePerformEvent) {
        _handleApplePerformEvent(event, emit);
      } else if (event is LoginWithGooglePerformEvent) {
        _handleGooglePerformEvent(event, emit);
      } else if (event is LoginSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is LoginFailedEvent) {
        _handleFailedEvent(event, emit);
      } else if (event is LoginCloseOnboardingEvent) {
        _handleCloseOnboardingEvent(event, emit);
      }
    });
  }

  void _handleInputEvent(
    LoginFieldInputEvent event,
    Emitter<LoginState> emit,
  ) {
    switch (event.field) {
      case InputFieldType.email:
        if (event.value != state.emailValue) {
          emit(state.copyWith(
            emailValue: event.value,
            emailError: const FieldError.none(),
          ));
        }
        break;
      case InputFieldType.password:
        if (event.value != state.passwordValue) {
          emit(state.copyWith(
            passwordValue: event.value,
            passwordError: const FieldError.none(),
          ));
        }
        break;
      default:
        break;
    }
  }

  void _handleValidateEvent(
    LoginFieldValidateEvent event,
    Emitter<LoginState> emit,
  ) {
    switch (event.field) {
      case InputFieldType.email:
        emit(state.copyWith(emailError: validateEmail(state.emailValue)));
        break;
      case InputFieldType.password:
        emit(state.copyWith(passwordError: validatePassword(state.passwordValue)));
        break;
      default:
        break;
    }
  }

  void _handlePerformEvent(
    LoginWithEmailPerformEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    _signInRepo.loginWithEmail(email: event.email, password: event.password).then((userId) async {
      if (userId != null) {
        return await SessionState().checkUserId(userId);
      }
    }).then((_) {
      add(LoginSuccessEvent());
      _authBloc.add(AuthUpdateEvent());
    }).catchError((e, s) {
      Log.error('Login error:', exc: e, stackTrace: s);
      add(LoginFailedEvent(e));
    });
  }

  void _handleFacebookPerformEvent(
    LoginWithFacebookPerformEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    _signInRepo.signInWithFacebook().then((userId) async {
      if (userId != null) {
        return await SessionState().checkUserId(userId);
      }
    }).then((_) {
      add(LoginSuccessEvent());
      _authBloc.add(AuthUpdateEvent());
    }).catchError((e, s) {
      Log.error('Facebook login error:', exc: e, stackTrace: s);
      add(LoginFailedEvent(e));
    });
  }

  void _handleApplePerformEvent(
    LoginWithApplePerformEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    _signInRepo.signInWithApple().then((userId) async {
      if (userId != null) {
        return await SessionState().checkUserId(userId);
      }
    }).then((_) {
      add(LoginSuccessEvent());
      _authBloc.add(AuthUpdateEvent());
    }).catchError((e, s) {
      Log.error('Apple login error:', exc: e, stackTrace: s);
      add(LoginFailedEvent(e));
    });
    ;
  }

  void _handleGooglePerformEvent(
    LoginWithGooglePerformEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    _signInRepo.signInWithGoogle().then((userId) async {
      if (userId != null) {
        return await SessionState().checkUserId(userId);
      }
    }).then((_) {
      add(LoginSuccessEvent());
      _authBloc.add(AuthUpdateEvent());
    }).catchError((e, s) {
      Log.error('Google login error:', exc: e, stackTrace: s);
      add(LoginFailedEvent(e));
    });
    ;
  }

  void _handleSuccessEvent(
    LoginSuccessEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.next));
  }

  void _handleFailedEvent(
    LoginFailedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.input));
  }

  void _handleCloseOnboardingEvent(
    LoginCloseOnboardingEvent event,
    Emitter<LoginState> emit,
  ) {
    SessionState().setOnboardingFlag(true);
    emit(state.copyWith(showOnboarding: false));
  }

  FieldError validateEmail(String emailValue) {
    if (emailValue.isEmpty) {
      return const FieldError(stringId: StringId.emailEmptyError);
    }
    return const FieldError.none();
  }

  FieldError validatePassword(String password) {
    if (password.isEmpty) {
      return const FieldError(stringId: StringId.passwordEmptyError);
    } else if (password.length < 8 || password.length > 35) {
      return const FieldError(stringId: StringId.passwordLengthError);
    }
    return const FieldError.none();
  }
}
