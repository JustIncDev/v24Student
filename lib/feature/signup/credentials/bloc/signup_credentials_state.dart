part of 'signup_credentials_bloc.dart';

class SignUpCredentialsState extends BaseBlocState {
  SignUpCredentialsState({
    this.firstNameValue = '',
    this.firstNameError = const FieldError.none(),
    this.lastNameValue = '',
    this.lastNameError = const FieldError.none(),
    this.emailValue = '',
    this.emailError = const FieldError.none(),
    this.countryNameValue = '',
    this.phoneValue = '',
    this.phoneError = const FieldError.none(),
    this.passwordValue = '',
    this.passwordError = const FieldError.none(),
    this.confirmValue = '',
    this.confirmError = const FieldError.none(),
    this.needFocusField = '',
    this.status = BaseScreenStatus.input,
  });

  final String firstNameValue;
  final FieldError firstNameError;
  final String lastNameValue;
  final FieldError lastNameError;
  final String emailValue;
  final FieldError emailError;
  final String countryNameValue;
  final String phoneValue;
  final FieldError phoneError;
  final String passwordValue;
  final FieldError passwordError;
  final String confirmValue;
  final FieldError confirmError;
  final String needFocusField;
  final BaseScreenStatus status;

  SignUpCredentialsState copyWith({
    String? firstNameValue,
    FieldError? firstNameError,
    String? lastNameValue,
    FieldError? lastNameError,
    String? emailValue,
    FieldError? emailError,
    String? countryNameValue,
    String? phoneValue,
    FieldError? phoneError,
    String? passwordValue,
    FieldError? passwordError,
    String? confirmValue,
    FieldError? confirmError,
    String? needFocusField,
    BaseScreenStatus? status,
    bool? agreeTerms,
  }) {
    return SignUpCredentialsState(
      firstNameValue: firstNameValue ?? this.firstNameValue,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameValue: lastNameValue ?? this.lastNameValue,
      lastNameError: lastNameError ?? this.lastNameError,
      phoneValue: phoneValue ?? this.phoneValue,
      phoneError: phoneError ?? this.phoneError,
      countryNameValue: countryNameValue ?? this.countryNameValue,
      emailValue: emailValue ?? this.emailValue,
      emailError: emailError ?? this.emailError,
      passwordValue: passwordValue ?? this.passwordValue,
      passwordError: passwordError ?? this.passwordError,
      confirmValue: confirmValue ?? this.confirmValue,
      confirmError: confirmError ?? this.confirmError,
      needFocusField: needFocusField ?? this.needFocusField,
      status: status ?? this.status,
    );
  }

  bool isFillAllFields() {
    return firstNameValue.trim().isNotEmpty &&
        lastNameValue.trim().isNotEmpty &&
        phoneValue.trim().isNotEmpty &&
        emailValue.trim().isNotEmpty &&
        passwordValue.trim().isNotEmpty &&
        confirmValue.trim().isNotEmpty;
  }

  bool isFieldError() {
    return !firstNameError.isNone() ||
        !lastNameError.isNone() ||
        !phoneError.isNone() ||
        !emailError.isNone() ||
        !passwordError.isNone() ||
        !confirmError.isNone();
  }

  @override
  List<Object?> get props => [
        firstNameValue,
        firstNameError,
        lastNameValue,
        lastNameError,
        phoneValue,
        phoneError,
        emailValue,
        emailError,
        passwordValue,
        passwordError,
        confirmValue,
        confirmError,
        needFocusField,
        status,
        countryNameValue,
      ];
}
