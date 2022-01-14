part of 'signup_code_bloc.dart';

class SignUpCodeState extends BaseBlocState {
  SignUpCodeState({
    this.currentCodePosition = 0,
    this.firstCodeValue = '',
    this.secondCodeValue = '',
    this.thirdCodeValue = '',
    this.fourthCodeValue = '',
    this.fifthCodeValue = '',
    this.sixthCodeValue = '',
    this.status = BaseScreenStatus.input,
    this.verificationCode = '',
    this.token,
  });

  final int currentCodePosition;
  final String firstCodeValue;
  final String secondCodeValue;
  final String thirdCodeValue;
  final String fourthCodeValue;
  final String fifthCodeValue;
  final String sixthCodeValue;
  final BaseScreenStatus status;
  final String? verificationCode;
  final int? token;

  SignUpCodeState copyWith({
    int? currentCodePosition,
    String? firstCodeValue,
    String? secondCodeValue,
    String? thirdCodeValue,
    String? fourthCodeValue,
    String? fifthCodeValue,
    String? sixthCodeValue,
    BaseScreenStatus? status,
    String? verificationCode,
    int? token,
  }) {
    return SignUpCodeState(
      currentCodePosition: currentCodePosition ?? this.currentCodePosition,
      firstCodeValue: firstCodeValue ?? this.firstCodeValue,
      secondCodeValue: secondCodeValue ?? this.secondCodeValue,
      thirdCodeValue: thirdCodeValue ?? this.thirdCodeValue,
      fourthCodeValue: fourthCodeValue ?? this.fourthCodeValue,
      fifthCodeValue: fifthCodeValue ?? this.fifthCodeValue,
      sixthCodeValue: sixthCodeValue ?? this.sixthCodeValue,
      status: status ?? this.status,
      verificationCode: verificationCode ?? this.verificationCode,
      token: token ?? this.token,
    );
  }

  bool showCursor(int index) {
    var value = '';
    if (index == 0) {
      value = firstCodeValue;
    } else if (index == 1) {
      value = secondCodeValue;
    } else if (index == 2) {
      value = thirdCodeValue;
    } else {
      value = fourthCodeValue;
    }
    return index == currentCodePosition && value.isEmpty;
  }

  @override
  List<Object?> get props => [
        currentCodePosition,
        firstCodeValue,
        secondCodeValue,
        thirdCodeValue,
        fourthCodeValue,
        fifthCodeValue,
        sixthCodeValue,
        status,
      ];
}
