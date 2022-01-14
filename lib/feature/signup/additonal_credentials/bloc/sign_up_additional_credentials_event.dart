part of 'sign_up_additional_credentials_bloc.dart';

enum DateType {
  month,
  day,
  year,
}

enum Gender { male, female }

abstract class SignUpAdditionalCredentialsEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class SignUpAdditionalCredentialsSelectMaleEvent extends SignUpAdditionalCredentialsEvent {
  SignUpAdditionalCredentialsSelectMaleEvent(this.gender);

  final Gender gender;

  @override
  List<Object> get props => [gender];
}

class SignUpAdditionalCredentialsInputDateEvent extends SignUpAdditionalCredentialsEvent {
  SignUpAdditionalCredentialsInputDateEvent(this.dateType, this.inputDate);

  final DateType dateType;
  final DateTime inputDate;
}

class SignUpAdditionalCredentialsPerformEvent extends SignUpAdditionalCredentialsEvent {
  SignUpAdditionalCredentialsPerformEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.country,
    this.password,
    this.gender,
    this.birthdayDate,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? password;
  final String? gender;
  final String? birthdayDate;
}

class SignUpAdditionalCredentialsSuccessEvent extends SignUpAdditionalCredentialsEvent {
  SignUpAdditionalCredentialsSuccessEvent();

  @override
  List<Object> get props => [];
}

class SignUpAdditionalCredentialsFailedEvent extends SignUpAdditionalCredentialsEvent {
  SignUpAdditionalCredentialsFailedEvent(this.exception);

  final Exception exception;
}
