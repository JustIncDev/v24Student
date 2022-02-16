part of 'edit_profile_bloc.dart';

enum EditProfileField {
  firstName,
  lastName,
  email,
  phone,
  country,
}

abstract class EditProfileEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class EditProfileFieldInputEvent extends EditProfileEvent {
  EditProfileFieldInputEvent({required this.field, required this.value});

  final EditProfileField field;
  final String value;

  @override
  List<Object> get props => [field, value];

  @override
  String toString() {
    return 'EditProfileFieldInputEvent{field: $field}';
  }
}

class EditProfileFieldValidateEvent extends EditProfileEvent {
  EditProfileFieldValidateEvent({required this.field});

  final EditProfileField field;

  @override
  List<Object> get props => [field];

  @override
  String toString() {
    return 'EditProfileFieldValidateEvent{field: $field}';
  }
}

class EditProfileRemoveFieldErrorsEvent extends EditProfileEvent {
  EditProfileRemoveFieldErrorsEvent({required this.field});

  final EditProfileField field;

  @override
  List<Object> get props => [field];

  @override
  String toString() {
    return 'EditProfileRemoveFieldErrorsEvent{field: $field}';
  }
}

class EditProfileUploadAvatarImageEvent extends EditProfileEvent {
  EditProfileUploadAvatarImageEvent({this.file});

  final File? file;

  @override
  List<Object?> get props => [file];
}

class EditProfileUploadAvatarImageSuccessEvent extends EditProfileEvent {
  EditProfileUploadAvatarImageSuccessEvent({this.file});

  final File? file;

  @override
  List<Object?> get props => [file];
}

class EditProfileUploadImageFailedEvent extends EditProfileEvent {}

class EditProfilePerformEvent extends EditProfileEvent {}

class EditProfileSuccessEvent extends EditProfileEvent {}

class EditProfileFailedEvent extends EditProfileEvent {
  EditProfileFailedEvent(this.exception);

  final Exception exception;
}
