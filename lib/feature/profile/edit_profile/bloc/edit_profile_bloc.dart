import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/text_field/field_error.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc()
      : super(
          EditProfileState(
            avatar: Avatar(),
          ),
        ) {
    on<EditProfileEvent>((event, emit) {});
  }
}
