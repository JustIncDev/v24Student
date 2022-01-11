part of 'login_bloc.dart';

abstract class LoginEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class LoginFieldInputEvent extends LoginEvent {
  LoginFieldInputEvent({required this.field, required this.value});

  final InputFieldType field;
  final String value;

  @override
  List<Object> get props => [field, value];

  @override
  String toString() {
    return 'LoginFieldInputEvent{field: $field}';
  }
}

class LoginFieldValidateEvent extends LoginEvent {
  LoginFieldValidateEvent({required this.field});

  final InputFieldType field;

  @override
  List<Object> get props => [field];

  @override
  String toString() {
    return 'LoginFieldValidateEvent{field: $field}';
  }
}

class LoginPerformEvent extends LoginEvent {}

class LoginWithApplePerformEvent extends LoginPerformEvent {
  LoginWithApplePerformEvent(this.credentials);

  final AuthorizationCredentialAppleID credentials;
}

class LoginFailedEvent extends LoginEvent {
  LoginFailedEvent(this.exception);

  final Exception exception;
}