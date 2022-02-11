import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_event.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_state.dart';
import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/profile_repo.dart';

import '../../logger/logger.dart';

class OwnerProfileBloc extends DataBloc<OwnerProfileEvent, OwnerProfileState> {
  OwnerProfileBloc({
    required this.profileRepo,
  }) : super(OwnerProfileState.empty()) {
    on<OwnerProfileEvent>((event, emit) async {
      if (event is OwnerProfileInitEvent) {
        _handleInitEvent(event, emit);
      } else if (event is OwnerProfileUpdatePerformEvent) {
        _handleUpdatePerformEvent(event, emit);
      } else if (event is OwnerProfileUpdateSuccessEvent) {
        _handleUpdateSuccessEvent(event, emit);
      } else if (event is OwnerProfileUpdateFailedEvent) {
        _handleUpdateFailedEvent(event, emit);
      }
    });
    _initSubscriptions();
    add(OwnerProfileInitEvent());
  }

  final ProfileRepo profileRepo;
  late StreamSubscription _profileRepoNotificationSubscription;

  @override
  Future<bool?> init() async {
    return null;
  }

  void _handleInitEvent(
    OwnerProfileInitEvent event,
    Emitter<OwnerProfileState> emit,
  ) {
    emit(state.copyWith(loading: true));
    //In future we can change it to load local data
    profileRepo.fetchProfile().catchError((e, s) {
      Log.error('Init profile error', exc: e, stackTrace: s);
    });
  }

  void _handleUpdatePerformEvent(
    OwnerProfileUpdatePerformEvent event,
    Emitter<OwnerProfileState> emit,
  ) {
    emit(state.copyWith(loading: true));
    profileRepo.fetchProfile().catchError((e, s) {
      Log.error('Fetch profile error', exc: e, stackTrace: s);
    });
  }

  void _handleUpdateSuccessEvent(
    OwnerProfileUpdateSuccessEvent event,
    Emitter<OwnerProfileState> emit,
  ) {
    emit(state.copyWith(profile: event.profile, loading: false));
  }

  void _handleUpdateFailedEvent(
    OwnerProfileUpdateFailedEvent event,
    Emitter<OwnerProfileState> emit,
  ) {
    emit(state.copyWith(loading: false));
  }

  @override
  Future<void> close() {
    return Future.wait([
      super.close(),
      _profileRepoNotificationSubscription.cancel(),
    ]);
  }

  void _initSubscriptions() {
    _profileRepoNotificationSubscription = profileRepo.dataNotificationStream.listen((event) {
      if (event is OwnerProfileDataNotification) {
        add(OwnerProfileUpdateSuccessEvent(event.profile));
      }
    });
  }
}
