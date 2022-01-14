part of 'signup_code_bloc.dart';

abstract class SignUpCodeEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class SignUpCodeInputEvent extends SignUpCodeEvent {
  SignUpCodeInputEvent(this.codeValue);

  final String codeValue;

  @override
  List<Object> get props => [codeValue];
}

class SignUpCodeClearEvent extends SignUpCodeEvent {}

class SignUpCodePerformEvent extends SignUpCodeEvent {}

class SignUpCodeSuccessEvent extends SignUpCodeEvent {}

class SignUpCodeFailedEvent extends SignUpCodeEvent {
  SignUpCodeFailedEvent(this.error);

  final Exception error;
}

class FirebaseCodeEvent extends SignUpCodeEvent {}

class FirebaseCodeSentEvent extends FirebaseCodeEvent {
  FirebaseCodeSentEvent({required this.verificationId, this.resendCode});

  final String verificationId;
  final int? resendCode;
}

class FirebaseCodeResendCodeEvent extends FirebaseCodeEvent {
  FirebaseCodeResendCodeEvent(this.phoneNumber, this.token);

  final String phoneNumber;
  final int? token;
}
