import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/repo/signup_repo.dart';
import 'package:v24_student_app/utils/session_state.dart';

part 'sign_up_additional_credentials_event.dart';
part 'sign_up_additional_credentials_state.dart';

class SignUpAdditionalCredentialsBloc
    extends Bloc<SignUpAdditionalCredentialsEvent, SignUpAdditionalCredentialsState> {
  final SignUpRepo _signUpRepo;
  final AuthBloc _authBloc;

  SignUpAdditionalCredentialsBloc({
    required SignUpRepo signUpRepo,
    required AuthBloc authBloc,
  })  : _signUpRepo = signUpRepo,
        _authBloc = authBloc,
        super(SignUpAdditionalCredentialsState()) {
    on<SignUpAdditionalCredentialsEvent>((event, emit) {
      if (event is SignUpAdditionalCredentialsSelectMaleEvent) {
        _handleSelectMaleEvent(event, emit);
      } else if (event is SignUpAdditionalCredentialsInputDateEvent) {
        _handleInputDateEvent(event, emit);
      } else if (event is SignUpAdditionalCredentialsPerformEvent) {
        _handlePerformEvent(event, emit);
      } else if (event is SignUpAdditionalCredentialsSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is SignUpAdditionalCredentialsFailedEvent) {
        _handleFailedEvent(event, emit);
      }
    });
  }

  void _handleSelectMaleEvent(
    SignUpAdditionalCredentialsSelectMaleEvent event,
    Emitter<SignUpAdditionalCredentialsState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  void _handleInputDateEvent(
    SignUpAdditionalCredentialsInputDateEvent event,
    Emitter<SignUpAdditionalCredentialsState> emit,
  ) {
    switch (event.dateType) {
      case DateType.month:
        emit(state.copyWith(month: event.inputDate));
        break;
      case DateType.day:
        emit(state.copyWith(day: event.inputDate));
        break;
      case DateType.year:
        emit(state.copyWith(year: event.inputDate));
        break;
    }
  }

  void _handlePerformEvent(
    SignUpAdditionalCredentialsPerformEvent event,
    Emitter<SignUpAdditionalCredentialsState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    _signUpRepo
        .signUpUser(
      firstName: event.firstName ?? '',
      lastName: event.lastName ?? '',
      email: event.email ?? '',
      phoneNumber: event.phoneNumber ?? '',
      gender: event.gender ?? '',
      birthdayDate: event.birthdayDate ?? '',
      country: event.country ?? '',
      password: event.password ?? '',
    )
        .then((userId) async {
      if (userId != null) {
        await SessionState().checkUserId(userId);
      }
    }).then((_) {
      add(SignUpAdditionalCredentialsSuccessEvent());
    }).catchError((e, s) {
      Log.error('SignUpCodeBloc', exc: e, stackTrace: s);
      add(SignUpAdditionalCredentialsFailedEvent(e));
    });
  }

  void _handleSuccessEvent(
    SignUpAdditionalCredentialsSuccessEvent event,
    Emitter<SignUpAdditionalCredentialsState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.next));
  }

  void _handleFailedEvent(
    SignUpAdditionalCredentialsFailedEvent event,
    Emitter<SignUpAdditionalCredentialsState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.input));
  }
}
