import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_bloc.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_event.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';
import 'package:v24_student_app/repo/file_repo.dart';
import 'package:v24_student_app/repo/profile_repo.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final OwnerProfileBloc _profileBloc;
  final ProfileRepo _profileRepo;
  final FileRepo _fileRepo;

  EditProfileBloc({
    required FileRepo fileRepo,
    required OwnerProfileBloc profileBloc,
    required ProfileRepo profileRepo,
  })  : _fileRepo = fileRepo,
        _profileBloc = profileBloc,
        _profileRepo = profileRepo,
        super(EditProfileState(
          firstNameValue: profileBloc.state.profile?.firstName ?? '',
          lastNameValue: profileBloc.state.profile?.lastName ?? '',
          emailValue: profileBloc.state.profile?.firebaseEmail?.email ?? '',
          countryNameValue: profileBloc.state.profile?.country ?? '',
          avatar: Avatar(url: profileBloc.state.profile?.profilePicture),
        )) {
    on<EditProfileEvent>((event, emit) {
      if (event is EditProfileFieldInputEvent) {
        _handleInputEvent(event, emit);
      } else if (event is EditProfileFieldValidateEvent) {
        _handleValidateEvent(event, emit);
      } else if (event is EditProfileRemoveFieldErrorsEvent) {
        _handleRemoveErrorsEvent(event, emit);
      } else if (event is EditProfileUploadAvatarImageEvent) {
        _handleUploadAvatarEvent(event, emit);
      } else if (event is EditProfileUploadAvatarImageSuccessEvent) {
        _handleUploadAvatarSuccessEvent(event, emit);
      } else if (event is EditProfileUploadImageFailedEvent) {
        _handleUploadAvatarFailedEvent(event, emit);
      } else if (event is EditProfilePerformEvent) {
        _handlePerformEvent(event, emit);
      } else if (event is EditProfileSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is EditProfileFailedEvent) {
        _handleFailedEvent(event, emit);
      }
    });
  }

  void _handleInputEvent(
    EditProfileFieldInputEvent event,
    Emitter<EditProfileState> emit,
  ) {
    final oldProfile = _profileBloc.state.profile;
    switch (event.field) {
      case EditProfileField.firstName:
        if (event.value != state.firstNameValue) {
          emit(
            state.copyWith(
              firstNameValue: event.value,
              firstNameError: const FieldError.none(),
              firstNameHasChanges: event.value != oldProfile?.firstName,
            ),
          );
        }
        break;
      case EditProfileField.lastName:
        if (event.value != state.lastNameValue) {
          emit(
            state.copyWith(
              lastNameValue: event.value,
              lastNameError: const FieldError.none(),
              lastNameHasChanges: event.value != oldProfile?.lastName,
            ),
          );
        }
        break;
      case EditProfileField.email:
        if (event.value != state.emailValue) {
          emit(
            state.copyWith(
              emailValue: event.value,
              emailError: const FieldError.none(),
              emailHasChanges: event.value != oldProfile?.firebaseEmail?.email,
            ),
          );
        }
        break;
      case EditProfileField.country:
        if (event.value != state.countryNameValue) {
          emit(
            state.copyWith(
              countryNameValue: event.value,
              countryNameHasChanges: event.value != oldProfile?.country,
            ),
          );
        }
        break;
    }
  }

  void _handleValidateEvent(
    EditProfileFieldValidateEvent event,
    Emitter<EditProfileState> emit,
  ) {
    switch (event.field) {
      case EditProfileField.firstName:
        emit(state.copyWith(
            firstNameError: validateName(
          state.firstNameValue,
          EditProfileField.firstName,
        )));
        break;
      case EditProfileField.lastName:
        emit(state.copyWith(
            lastNameError: validateName(
          state.lastNameValue,
          EditProfileField.lastName,
        )));
        break;
      case EditProfileField.email:
        emit(state.copyWith(emailError: validateEmail(state.emailValue)));
        break;
      default:
        break;
    }
  }

  void _handleRemoveErrorsEvent(
    EditProfileRemoveFieldErrorsEvent event,
    Emitter<EditProfileState> emit,
  ) {
    switch (event.field) {
      case EditProfileField.firstName:
        emit(state.copyWith(firstNameError: const FieldError.none()));
        break;
      case EditProfileField.lastName:
        emit(state.copyWith(lastNameError: const FieldError.none()));
        break;
      case EditProfileField.email:
        emit(state.copyWith(emailError: const FieldError.none()));
        break;
      case EditProfileField.country:
        break;
    }
  }

  void _handleUploadAvatarEvent(
    EditProfileUploadAvatarImageEvent event,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    if (event.file == null) {
      add(EditProfileUploadAvatarImageSuccessEvent());
    } else {
      var file = event.file;
      if (file != null) {
        _fileRepo.uploadImage(file: file).then((value) {
          if (value) {
            add(EditProfileUploadAvatarImageSuccessEvent(file: event.file));
          }
        }).catchError((e, s) {
          add(EditProfileUploadImageFailedEvent());
        });
      }
    }
  }

  void _handleUploadAvatarSuccessEvent(
    EditProfileUploadAvatarImageSuccessEvent event,
    Emitter<EditProfileState> emit,
  ) {
    var deletePhoto = state.avatar.url != null;
    emit(state.copyWith(
      avatar: Avatar(file: event.file),
      status: BaseScreenStatus.input,
      avatarHasChanges: deletePhoto,
    ));
  }

  void _handleUploadAvatarFailedEvent(
    EditProfileUploadImageFailedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    // sendAppMessage(AppBusMessage(stringId: StringId.failedUploadFile));
    emit(state.copyWith(status: BaseScreenStatus.input));
  }

  void _handlePerformEvent(
    EditProfilePerformEvent event,
    Emitter<EditProfileState> emit,
  ) {
    var firstNameValidate = validateName(state.firstNameValue, EditProfileField.firstName);
    var lastNameValidate = validateName(state.lastNameValue, EditProfileField.lastName);
    var emailValidate = validateEmail(state.emailValue);
    if (!firstNameValidate.isNone()) {
      emit(state.copyWith(firstNameError: firstNameValidate));
    } else if (!lastNameValidate.isNone()) {
      emit(state.copyWith(lastNameError: lastNameValidate));
    } else if (!emailValidate.isNone()) {
      emit(state.copyWith(emailError: emailValidate));
    } else {
      emit(state.copyWith(status: BaseScreenStatus.lock));
      _profileRepo
          .editProfile(
        firstName: state.firstNameValue,
        lastName: state.lastNameValue,
        email: state.emailValue,
        avatar: state.avatar.url,
        country: state.countryNameValue,
      )
          .then((ownerProfile) {
        _profileBloc.add(OwnerProfileUpdateSuccessEvent(ownerProfile));
        add(EditProfileSuccessEvent());
      }).catchError((e, s) {
        add(EditProfileFailedEvent(e));
      });
    }
  }

  void _handleSuccessEvent(
    EditProfileSuccessEvent event,
    Emitter<EditProfileState> emit,
  ) {}

  void _handleFailedEvent(
    EditProfileFailedEvent event,
    Emitter<EditProfileState> emit,
  ) {}

  FieldError validateName(String userNameValue, EditProfileField type) {
    if (userNameValue.isEmpty) {
      if (type == EditProfileField.firstName) {
        return const FieldError(stringId: StringId.firstNameEmptyError);
      } else {
        return const FieldError(stringId: StringId.lastNameEmptyError);
      }
    }
    return const FieldError.none();
  }

  FieldError validatePhone(String phoneValue) {
    if (phoneValue.isEmpty) {
      return const FieldError(stringId: StringId.phoneEmptyError);
    }
    return const FieldError.none();
  }

  FieldError validateEmail(String emailValue) {
    if (emailValue.isEmpty) {
      return const FieldError(stringId: StringId.emailEmptyError);
    }
    return const FieldError.none();
  }
}
