part of 'signup_code_bloc.dart';

class SignUpCodeState extends BaseBlocState {
  SignUpCodeState({
    this.currentCodePosition = 0,
    this.firstCodeValue = '',
    this.secondCodeValue = '',
    this.thirdCodeValue = '',
    this.fourthCodeValue = '',
  });

  final int currentCodePosition;
  final String firstCodeValue;
  final String secondCodeValue;
  final String thirdCodeValue;
  final String fourthCodeValue;

  SignUpCodeState copyWith({
    int? currentCodePosition,
    String? firstCodeValue,
    String? secondCodeValue,
    String? thirdCodeValue,
    String? fourthCodeValue,
  }) {
    return SignUpCodeState(
      currentCodePosition: currentCodePosition ?? this.currentCodePosition,
      firstCodeValue: firstCodeValue ?? this.firstCodeValue,
      secondCodeValue: secondCodeValue ?? this.secondCodeValue,
      thirdCodeValue: thirdCodeValue ?? this.thirdCodeValue,
      fourthCodeValue: fourthCodeValue ?? this.fourthCodeValue,
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
      ];
}
