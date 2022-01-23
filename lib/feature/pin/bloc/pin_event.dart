part of 'pin_bloc.dart';

@immutable
abstract class PinEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class PinInitEvent extends PinEvent {}

class PinInputEvent extends PinEvent {
  PinInputEvent(this.codeValue);

  final String codeValue;

  @override
  List<Object> get props => [codeValue];
}

class PinClearEvent extends PinEvent {}

class PinConfirmInitEvent extends PinEvent {}

class PinPerformEvent extends PinEvent {}

class PinSuccessEvent extends PinEvent {}

class PinFailedEvent extends PinEvent {}
