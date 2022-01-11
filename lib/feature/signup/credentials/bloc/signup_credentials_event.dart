part of 'signup_credentials_bloc.dart';

abstract class SignUpCredentialsEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class SignUpFieldInputEvent extends SignUpCredentialsEvent {
  SignUpFieldInputEvent({required this.field, required this.value});

  final InputFieldType field;
  final String value;

  @override
  List<Object> get props => [field, value];

  @override
  String toString() {
    return 'SignUpFieldInputEvent{field: $field}';
  }
}

class SignUpFieldValidateEvent extends SignUpCredentialsEvent {
  SignUpFieldValidateEvent({required this.field});

  final InputFieldType field;

  @override
  List<Object> get props => [field];

  @override
  String toString() {
    return 'SignUpFieldValidateEvent{field: $field}';
  }
}

class SignUpPerformEvent extends SignUpCredentialsEvent {}

class SignUpSuccessEvent extends SignUpCredentialsEvent {
  SignUpSuccessEvent({required this.verificationToken});

  final String verificationToken;

  @override
  List<Object> get props => [verificationToken];

  @override
  String toString() {
    return 'SignUpSuccessEvent{}';
  }
}

class SignUpFailedEvent extends SignUpCredentialsEvent {
  SignUpFailedEvent(this.exception);

  final Exception exception;
}
