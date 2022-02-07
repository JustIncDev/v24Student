part of 'profile_bloc.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class ProfileInitEvent extends ProfileEvent {}

class ProfileSuccessEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {}

class ProfileFailedEvent extends ProfileEvent {}