import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/utils/session_state.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc({
    bool enterScreen = false,
  }) : super(PinState(page: enterScreen ? PinPage.enter : PinPage.set)) {
    on<PinEvent>((event, emit) async {
      if (event is PinInitEvent) {
        await _handleInitEvent(event, emit);
      } else if (event is PinInputEvent) {
        _handleInputEvent(event, emit);
      } else if (event is PinClearEvent) {
        _handleClearEvent(event, emit);
      } else if (event is PinConfirmInitEvent) {
        _handleConfirmInitEvent(event, emit);
      } else if (event is PinPerformEvent) {
        _handlePerformEvent(event, emit);
      }
    });
  }

  Future<void> _handleInitEvent(
    PinInitEvent event,
    Emitter<PinState> emit,
  ) async {
    final auth = LocalAuthentication();
    var canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      var availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face)) {
        emit(state.copyWith(type: BiometricType.face));
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        emit(state.copyWith(type: BiometricType.fingerprint));
      }
    }
  }

  void _handleInputEvent(
    PinInputEvent event,
    Emitter<PinState> emit,
  ) {
    emit(
      state.copyWith(
        pinValue: state.page == PinPage.set ? state.pinValue + event.codeValue : state.pinValue,
        currentCodePosition: state.currentCodePosition + 1,
        confirmPinValue: state.page == PinPage.set
            ? state.confirmPinValue
            : state.confirmPinValue + event.codeValue,
      ),
    );
  }

  void _handleClearEvent(
    PinClearEvent event,
    Emitter<PinState> emit,
  ) {
    var pinValue = state.page == PinPage.set ? state.pinValue : state.confirmPinValue;
    if (pinValue.isNotEmpty) {
      pinValue = pinValue.substring(0, pinValue.length - 1);
    }
    emit(
      state.copyWith(
          pinValue: state.page == PinPage.set ? pinValue : state.pinValue,
          confirmPinValue: state.page == PinPage.confirm ? pinValue : state.confirmPinValue,
          currentCodePosition: state.currentCodePosition > 0
              ? state.currentCodePosition - 1
              : state.currentCodePosition),
    );
  }

  void _handleConfirmInitEvent(
    PinConfirmInitEvent event,
    Emitter<PinState> emit,
  ) {
    emit(state.copyWith(currentCodePosition: 0, page: PinPage.confirm));
  }

  void _handlePerformEvent(
    PinPerformEvent event,
    Emitter<PinState> emit,
  ) {
    if (state.confirmPinValue != state.pinValue) {
      add(PinFailedEvent());
      emit(state.copyWith(currentCodePosition: 0, confirmPinValue: ''));
    } else {
      SessionState().setPinCode(state.pinValue).then((value) {
        emit(state.copyWith(status: BaseScreenStatus.next));
      });
    }
  }
}
