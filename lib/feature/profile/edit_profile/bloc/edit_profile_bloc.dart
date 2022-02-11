import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_bloc.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';
import 'package:v24_student_app/repo/profile_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final OwnerProfileBloc _profileBloc;
  final ProfileRepo _profileRepo;

  EditProfileBloc({
    required OwnerProfileBloc profileBloc,
    required ProfileRepo profileRepo,
  })  : _profileBloc = profileBloc,
        _profileRepo = profileRepo,
        super(EditProfileState(
          avatar: Avatar(url: profileBloc.state.profile?.profilePicture),
        )) {
    on<EditProfileEvent>((event, emit) {
      if (event is EditProfileFieldInputEvent) {
      } else if (event is EditProfileFieldValidateEvent) {
      } else if (event is EditProfileRemoveFieldErrorsEvent) {
      } else if (event is EditProfileUploadAvatarImageEvent) {
      } else if (event is EditProfileUploadAvatarImageSuccessEvent) {
      } else if (event is EditProfileUploadImageFailedEvent) {
      } else if (event is EditProfilePerformEvent) {
      } else if (event is EditProfileSuccessEvent) {
      } else if (event is EditProfileFailedEvent) {}
    });
  }

  void _handleInputEvent() {}

  void _handleValidateEvent() {}

  void _handleRemoveErrorsEvent() {}

  void _handleUploadAvatarEvent() {}

  void _handleUploadAvatarSuccessEvent() {}

  void _handleUploadAvatarFailedEvent() {}

  void _handlePerformEvent() {}

  void _handleSuccessEvent() {}

  void _handleFailedEvent() {}
}
