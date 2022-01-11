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

class SignUpCodeErrorEvent extends SignUpCodeEvent {}
