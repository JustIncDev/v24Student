import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/repo/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileBloc({
    required ProfileRepo profileRepo,
  })  : _profileRepo = profileRepo,
        super(ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileInitEvent) {
        await _handleInitEvent(event, emit);
      }
    });
    add(ProfileInitEvent());
  }

  Future<void> _handleInitEvent(
    ProfileInitEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    var userProfile = await _profileRepo.getUserProfile();
    if (userProfile != null) {
      emit(state.copyWith(
        status: BaseScreenStatus.input,
        firstName: userProfile.firstName,
        lastName: userProfile.lastName,
        email: userProfile.firebaseEmail?.email,
        phoneNumber: userProfile.firebasePhone?.phoneNumber,
        avatarUrl: userProfile.profilePicture,
      ));
    }
  }
}
