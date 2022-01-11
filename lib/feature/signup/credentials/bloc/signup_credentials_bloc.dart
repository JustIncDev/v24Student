import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';
import 'package:v24_student_app/global/ui/text_field/input_field_type.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

part 'signup_credentials_event.dart';
part 'signup_credentials_state.dart';

class SignUpCredentialsBloc extends Bloc<SignUpCredentialsEvent, SignUpCredentialsState> {
  SignUpCredentialsBloc() : super(SignUpCredentialsState()) {
    on<SignUpCredentialsEvent>((event, emit) {
      if (event is SignUpFieldInputEvent) {
        _handleFieldInputEvent(event, emit);
      } else if (event is SignUpFieldValidateEvent) {
        _handleFieldValidateEvent(event, emit);
      } else if (event is SignUpPerformEvent) {
        _handlePerformEvent(event, emit);
      } else if (event is SignUpSuccessEvent) {
        _handleSuccessEvent(event, emit);
      }
    });
  }

  void _handleFieldInputEvent(
    SignUpFieldInputEvent event,
    Emitter<SignUpCredentialsState> emit,
  ) {
    switch (event.field) {
      case InputFieldType.firstName:
        if (event.value != state.firstNameValue) {
          emit(state.copyWith(
            firstNameValue: event.value,
            firstNameError: const FieldError.none(),
          ));
        }
        break;
      case InputFieldType.lastName:
        if (event.value != state.lastNameValue) {
          emit(state.copyWith(
            lastNameValue: event.value,
            lastNameError: const FieldError.none(),
          ));
        }
        break;
      case InputFieldType.email:
        if (event.value != state.emailValue) {
          emit(state.copyWith(
            emailValue: event.value,
            emailError: const FieldError.none(),
          ));
        }
        break;
      case InputFieldType.phone:
        if (event.value != state.phoneValue) {
          emit(state.copyWith(
            phoneValue: event.value,
            phoneError: const FieldError.none(),
          ));
        }
        break;
      case InputFieldType.country:
        if (event.value != state.countryNameValue) {
          emit(state.copyWith(countryNameValue: event.value));
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
      case InputFieldType.confirmPassword:
        if (event.value != state.confirmValue) {
          emit(state.copyWith(
            confirmValue: event.value,
            confirmError: const FieldError.none(),
          ));
        }
        break;
    }
  }

  void _handleFieldValidateEvent(
    SignUpFieldValidateEvent event,
    Emitter<SignUpCredentialsState> emit,
  ) {
    switch (event.field) {
      case InputFieldType.firstName:
        emit(state.copyWith(
            firstNameError: validateName(
          state.firstNameValue,
          InputFieldType.firstName,
        )));
        break;
      case InputFieldType.lastName:
        emit(state.copyWith(
            lastNameError: validateName(
          state.lastNameValue,
          InputFieldType.lastName,
        )));
        break;
      case InputFieldType.phone:
        emit(state.copyWith(phoneError: validatePhone(state.phoneValue)));
        break;
      case InputFieldType.email:
        emit(state.copyWith(emailError: validateEmail(state.emailValue)));
        break;
      case InputFieldType.password:
        emit(state.copyWith(passwordError: validatePassword(state.passwordValue)));
        break;
      case InputFieldType.confirmPassword:
        if (state.confirmError.isNone()) {
          emit(state.copyWith(confirmError: validatePassword(state.confirmValue)));
        }
        break;
      default:
        break;
    }
  }

  void _handlePerformEvent(
    SignUpPerformEvent event,
    Emitter<SignUpCredentialsState> emit,
  ) {
    print(state.firstNameValue +
        state.lastNameValue +
        state.emailValue +
        state.phoneValue +
        state.countryNameValue +
        state.passwordValue +
        state.confirmValue);
    var newState = validationFields(state);
    if (newState.isFieldError()) {
      emit(newState);
    } else {
      emit(state.copyWith(status: BaseScreenStatus.lock));
      add(SignUpSuccessEvent(verificationToken: 'verificationToken'));

      ///Add sign up logic
    }
  }

  void _handleSuccessEvent(
    SignUpSuccessEvent event,
    Emitter<SignUpCredentialsState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.next));
  }

  FieldError validateName(String userNameValue, InputFieldType type) {
    if (userNameValue.isEmpty) {
      if (type == InputFieldType.firstName) {
        return const FieldError(stringId: StringId.firstNameEmptyError);
      } else {
        return const FieldError(stringId: StringId.lastNameEmptyError);
      }
    }
    return const FieldError.none();
  }

  FieldError validatePhone(String phoneValue) {
    if (phoneValue.isEmpty) {
      return const FieldError(stringId: StringId.phoneEmptyError);
    }
    return const FieldError.none();
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

  SignUpCredentialsState validationFields(SignUpCredentialsState currentState) {
    var firstNameError = validateName(currentState.firstNameValue, InputFieldType.firstName);
    var lastNameError = validateName(currentState.lastNameValue, InputFieldType.lastName);
    var phoneError = validatePhone(currentState.phoneValue);
    var emailError = validateEmail(currentState.emailValue);
    var passwordError = validatePassword(currentState.passwordValue);
    var confirmError = validatePassword(currentState.confirmValue);
    if (passwordError.isNone() &&
        confirmError.isNone() &&
        currentState.passwordValue != currentState.confirmValue) {
      confirmError = const FieldError(stringId: StringId.passwordNotEqualityError);
    }
    return currentState.copyWith(
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      phoneError: phoneError,
      emailError: emailError,
      passwordError: passwordError,
      confirmError: confirmError,
      needFocusField: const Uuid().v4(),
      status: BaseScreenStatus.input,
    );
  }
}
