import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';
import 'package:v24_student_app/global/ui/text_field/input_field_type.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) {
      if (event is LoginFieldInputEvent) {
        _handleInputEvent(event, emit);
      } else if (event is LoginFieldValidateEvent) {
        _handleValidateEvent(event, emit);
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
