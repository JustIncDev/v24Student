import 'package:flutter/foundation.dart';
import 'package:v24_student_app/domain/user_profile.dart';
import 'package:v24_student_app/global/bloc.dart';

@immutable
abstract class OwnerProfileEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class OwnerProfileInitEvent extends OwnerProfileEvent {}

class OwnerProfileUpdatePerformEvent extends OwnerProfileEvent {}

class OwnerProfileUpdateSuccessEvent extends OwnerProfileEvent {
  OwnerProfileUpdateSuccessEvent(this.profile);

  final UserProfile? profile;

  @override
  List<Object?> get props => [profile];
}

class OwnerProfileUpdateFailedEvent extends OwnerProfileEvent {}
