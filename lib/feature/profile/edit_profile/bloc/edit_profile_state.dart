part of 'edit_profile_bloc.dart';

class Avatar {
  const Avatar({this.url, this.file});

  final String? url;
  final File? file;
}

class EditProfileState extends BaseBlocState {
  EditProfileState({
    this.firstNameValue = '',
    this.firstNameError = const FieldError.none(),
    this.firstNameHasChanges = false,
    this.lastNameValue = '',
    this.lastNameError = const FieldError.none(),
    this.lastNameHasChanges = false,
    this.emailValue = '',
    this.emailError = const FieldError.none(),
    this.emailHasChanges = false,
    this.countryNameValue = '',
    this.countryNameHasChanges = false,
    required this.avatar,
    this.avatarHasChanges = false,
    this.needFocusField = '',
    this.status = BaseScreenStatus.input,
  });

  final String firstNameValue;
  final FieldError firstNameError;
  final bool firstNameHasChanges;
  final String lastNameValue;
  final FieldError lastNameError;
  final bool lastNameHasChanges;
  final String emailValue;
  final FieldError emailError;
  final bool emailHasChanges;
  final String countryNameValue;
  final bool countryNameHasChanges;
  final Avatar avatar;
  final bool avatarHasChanges;
  final String needFocusField;
  final BaseScreenStatus status;

  EditProfileState copyWith({
    String? firstNameValue,
    FieldError? firstNameError,
    bool? firstNameHasChanges,
    String? lastNameValue,
    FieldError? lastNameError,
    bool? lastNameHasChanges,
    String? emailValue,
    FieldError? emailError,
    bool? emailHasChanges,
    String? countryNameValue,
    bool? countryNameHasChanges,
    Avatar? avatar,
    bool? avatarHasChanges,
    String? needFocusField,
    BaseScreenStatus? status,
  }) {
    return EditProfileState(
      firstNameValue: firstNameValue ?? this.firstNameValue,
      firstNameError: firstNameError ?? this.firstNameError,
      firstNameHasChanges: firstNameHasChanges ?? this.firstNameHasChanges,
      lastNameValue: lastNameValue ?? this.lastNameValue,
      lastNameError: lastNameError ?? this.lastNameError,
      lastNameHasChanges: lastNameHasChanges ?? this.lastNameHasChanges,
      emailValue: emailValue ?? this.emailValue,
      emailError: emailError ?? this.emailError,
      emailHasChanges: emailHasChanges ?? this.emailHasChanges,
      countryNameValue: countryNameValue ?? this.countryNameValue,
      countryNameHasChanges: countryNameHasChanges ?? this.countryNameHasChanges,
      avatar: avatar ?? this.avatar,
      avatarHasChanges: avatarHasChanges ?? this.avatarHasChanges,
      needFocusField: needFocusField ?? this.needFocusField,
      status: status ?? this.status,
    );
  }

  bool hasChanges() {
    return firstNameHasChanges ||
        lastNameHasChanges ||
        emailHasChanges ||
        countryNameHasChanges ||
        avatarHasChanges;
  }

  bool isFieldError() {
    return !firstNameError.isNone() ||
        !lastNameError.isNone() ||
        !emailError.isNone();
  }

  bool isFillAllRequiredFields() {
    return (firstNameValue.trim().isNotEmpty) &&
        (lastNameValue.trim().isNotEmpty) &&
        (emailValue.trim().isNotEmpty);
  }

  @override
  List<Object?> get props => [
        firstNameValue,
        firstNameError,
        firstNameHasChanges,
        lastNameValue,
        lastNameError,
        lastNameHasChanges,
        emailValue,
        emailError,
        emailHasChanges,
        countryNameValue,
        countryNameHasChanges,
        avatar,
        avatarHasChanges,
        needFocusField,
        status,
      ];
}
