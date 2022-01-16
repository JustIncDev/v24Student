import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/repo/sign_up_repo.dart';

part 'signup_code_event.dart';
part 'signup_code_state.dart';

class SignUpCodeBloc extends Bloc<SignUpCodeEvent, SignUpCodeState> {
  final SignUpRepo _signUpRepo;
  final AuthBloc _authBloc;

  SignUpCodeBloc({
    required SignUpRepo signUpRepo,
    required AuthBloc authBloc,
    required String phoneNumber,
  })  : _signUpRepo = signUpRepo,
        _authBloc = authBloc,
        super(SignUpCodeState()) {
    _initialize(phoneNumber);
    on<SignUpCodeEvent>((event, emit) {
      if (event is SignUpCodeInputEvent) {
        _handleInputEvent(event, emit);
      } else if (event is SignUpCodeClearEvent) {
        _handleClearEvent(event, emit);
      } else if (event is SignUpCodePerformEvent) {
        _handlePerformEvent(event, emit);
      } else if (event is SignUpCodeFailedEvent) {
        _handleFailedEvent(event, emit);
      } else if (event is SignUpCodeSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is FirebaseCodeSentEvent) {
        _handleFirebaseCodeSentEvent(event, emit);
      } else if (event is FirebaseCodeResendCodeEvent) {
        _handleFirebaseCodeResendEvent(event, emit);
      }
    });
  }

  void _initialize(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          add(SignUpCodeSuccessEvent());
        },
        verificationFailed: (FirebaseException e) {
          add(SignUpCodeFailedEvent(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          add(FirebaseCodeSentEvent(verificationId: verificationId, resendCode: resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on Exception catch (e) {
      add(SignUpCodeFailedEvent(e));
    }
  }

  void _handleInputEvent(
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
    } else if (state.fifthCodeValue.isEmpty) {
      emit(state.copyWith(fifthCodeValue: event.codeValue, currentCodePosition: 5));
    } else if (state.sixthCodeValue.isEmpty) {
      emit(state.copyWith(sixthCodeValue: event.codeValue, currentCodePosition: 6));
      add(SignUpCodePerformEvent());
    }
  }

  void _handleClearEvent(
    SignUpCodeClearEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    if (state.fifthCodeValue.isNotEmpty) {
      emit(state.copyWith(sixthCodeValue: '', currentCodePosition: 5));
    } else if (state.fifthCodeValue.isNotEmpty) {
      emit(state.copyWith(fifthCodeValue: '', currentCodePosition: 4));
    } else if (state.fourthCodeValue.isNotEmpty) {
      emit(state.copyWith(fourthCodeValue: '', currentCodePosition: 3));
    } else if (state.thirdCodeValue.isNotEmpty) {
      emit(state.copyWith(thirdCodeValue: '', currentCodePosition: 2));
    } else if (state.secondCodeValue.isNotEmpty) {
      emit(state.copyWith(secondCodeValue: '', currentCodePosition: 1));
    } else if (state.firstCodeValue.isNotEmpty) {
      emit(state.copyWith(firstCodeValue: '', currentCodePosition: 0));
    }
  }

  Future<void> _handlePerformEvent(
    SignUpCodePerformEvent event,
    Emitter<SignUpCodeState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    var credential = PhoneAuthProvider.credential(
      verificationId: state.verificationCode ?? '',
      smsCode: state.firstCodeValue +
          state.secondCodeValue +
          state.thirdCodeValue +
          state.fourthCodeValue +
          state.fifthCodeValue +
          state.sixthCodeValue,
    );
    var response = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    if (response?.user != null) {
      add(SignUpCodeSuccessEvent());
    } else {
      add(SignUpCodeFailedEvent(Exception('Error linked user')));
    }
  }

  void _handleFailedEvent(
    SignUpCodeFailedEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.input));
  }

  void _handleSuccessEvent(
    SignUpCodeSuccessEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'firebasePhone.verified': true});
    emit(state.copyWith(status: BaseScreenStatus.next));
  }

  void _handleFirebaseCodeSentEvent(
    FirebaseCodeSentEvent event,
    Emitter<SignUpCodeState> emit,
  ) {
    emit(state.copyWith(verificationCode: event.verificationId, token: event.resendCode));
  }

  Future<void> _handleFirebaseCodeResendEvent(
    FirebaseCodeResendCodeEvent event,
    Emitter<SignUpCodeState> emit,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseException e) {
          add(SignUpCodeFailedEvent(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          add(FirebaseCodeSentEvent(verificationId: verificationId, resendCode: resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: event.token);
  }
}
