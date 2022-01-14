part of 'sign_up_additional_credentials_bloc.dart';

class SignUpAdditionalCredentialsState extends BaseBlocState {
  final Gender gender;
  final DateTime? month;
  final DateTime? day;
  final DateTime? year;
  final BaseScreenStatus status;

  SignUpAdditionalCredentialsState({
    this.gender = Gender.female,
    this.month,
    this.day,
    this.year,
    this.status = BaseScreenStatus.input,
  });

  SignUpAdditionalCredentialsState copyWith({
    Gender? gender,
    DateTime? month,
    DateTime? day,
    DateTime? year,
    BaseScreenStatus? status,
  }) {
    return SignUpAdditionalCredentialsState(
      gender: gender ?? this.gender,
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [gender, month, day, year, status];
}
