part of 'login_bloc.dart';

enum LoginStatus { input, perform, success }

enum LoginType { email, social }

class LoginState extends BaseBlocState {
  LoginState({
    this.emailValue = '',
    this.emailError = const FieldError.none(),
    this.passwordValue = '',
    this.passwordError = const FieldError.none(),
    this.needFocusField = '',
    this.status = LoginStatus.input,
    this.loginType = LoginType.email,
  });

  final String emailValue;
  final FieldError emailError;
  final String passwordValue;
  final FieldError passwordError;
  final String needFocusField;
  final LoginStatus status;
  final LoginType loginType;

  LoginState copyWith({
    String? emailValue,
    FieldError? emailError,
    String? passwordValue,
    FieldError? passwordError,
    String? needFocusField,
    LoginStatus? status,
    LoginType? loginType,
  }) {
    return LoginState(
      emailValue: emailValue ?? this.emailValue,
      emailError: emailError ?? this.emailError,
      passwordValue: passwordValue ?? this.passwordValue,
      passwordError: passwordError ?? this.passwordError,
      needFocusField: needFocusField ?? this.needFocusField,
      status: status ?? this.status,
      loginType: loginType ?? this.loginType,
    );
  }

  bool isFillAllFields() {
    if (loginType == LoginType.email) {
      return emailValue.trim().isNotEmpty && passwordValue.trim().isNotEmpty;
    }
    return false;
  }

  bool isFieldError() {
    if (loginType == LoginType.email) {
      return !emailError.isNone() || !passwordError.isNone();
    } else {
      return false;
    }
  }

  String getErrorMessage(BuildContext context) {
    var message = '';
    if (!passwordError.isNone()) {
      message = passwordError.getMessage(context)!;
    }
    if (!emailError.isNone()) {
      message = emailError.getMessage(context)!;
    }
    return message;
  }

  @override
  List<Object> get props => [
        emailValue,
        emailError,
        passwordValue,
        passwordError,
        needFocusField,
        status,
        loginType,
      ];
}
