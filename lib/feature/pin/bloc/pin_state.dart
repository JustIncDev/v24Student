part of 'pin_bloc.dart';

enum PinPage {
  enter,
  set,
  confirm,
}

class PinState extends BaseBlocState {
  PinState({
    this.currentCodePosition = 0,
    this.pinValue = '',
    this.confirmPinValue = '',
    this.status = BaseScreenStatus.input,
    this.page = PinPage.set,
    this.type,
  });

  final int currentCodePosition;
  final String pinValue;
  final String confirmPinValue;
  final BaseScreenStatus status;
  final PinPage page;
  final BiometricType? type;

  PinState copyWith({
    int? currentCodePosition,
    String? pinValue,
    String? confirmPinValue,
    BaseScreenStatus? status,
    PinPage? page,
    BiometricType? type,
  }) {
    return PinState(
      currentCodePosition: currentCodePosition ?? this.currentCodePosition,
      pinValue: pinValue ?? this.pinValue,
      confirmPinValue: confirmPinValue ?? this.confirmPinValue,
      status: status ?? this.status,
      page: page ?? this.page,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        currentCodePosition,
        pinValue,
        confirmPinValue,
        status,
        page,
      ];
}
