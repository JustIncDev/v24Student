import 'package:bloc/bloc.dart';
import 'package:v24_student_app/global/bloc.dart';

part 'signup_code_event.dart';
part 'signup_code_state.dart';

class SignUpCodeBloc extends Bloc<SignUpCodeEvent, SignUpCodeState> {
  SignUpCodeBloc() : super(SignUpCodeState()) {
    on<SignUpCodeEvent>((event, emit) {
      if (event is SignUpCodeInputEvent) {
        _handleCodeInputEvent(event, emit);
      } else if (event is SignUpCodeClearEvent) {
        _handleCodeClearEvent(event, emit);
      }
    });
  }

  void _handleCodeInputEvent(
    SignUpCodeInputEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    if (state.firstCodeValue.isEmpty) {
      emit(state.copyWith(firstCodeValue: event.codeValue, currentCodePosition: 1));
    } else if (state.secondCodeValue.isEmpty) {
      emit(state.copyWith(secondCodeValue: event.codeValue, currentCodePosition: 2));
    } else if (state.thirdCodeValue.isEmpty) {
      emit(state.copyWith(thirdCodeValue: event.codeValue, currentCodePosition: 3));
    } else if (state.fourthCodeValue.isEmpty) {
      emit(state.copyWith(fourthCodeValue: event.codeValue, currentCodePosition: 4));
    }
  }

  void _handleCodeClearEvent(
    SignUpCodeClearEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    if (state.fourthCodeValue.isNotEmpty) {
      emit(state.copyWith(fourthCodeValue: '', currentCodePosition: 3));
    } else if (state.thirdCodeValue.isNotEmpty) {
      emit(state.copyWith(thirdCodeValue: '', currentCodePosition: 2));
    } else if (state.secondCodeValue.isNotEmpty) {
      emit(state.copyWith(secondCodeValue: '', currentCodePosition: 1));
    } else if (state.firstCodeValue.isNotEmpty) {
      emit(state.copyWith(firstCodeValue: '', currentCodePosition: 0));
    }
  }
}
