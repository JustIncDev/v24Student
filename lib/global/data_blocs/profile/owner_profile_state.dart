import 'package:flutter/foundation.dart';
import 'package:v24_student_app/domain/user_profile.dart';
import 'package:v24_student_app/global/bloc.dart';

@immutable
class OwnerProfileState extends BaseBlocState {
  OwnerProfileState({this.profile, this.loading});

  OwnerProfileState.empty()
      : this.profile = null,
        this.loading = false;

  final UserProfile? profile;
  final bool? loading;

  OwnerProfileState copyWith({bool? loading, UserProfile? profile}) {
    return OwnerProfileState(
      profile: profile ?? this.profile,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'OwnerProfileState{profile: $profile}';
  }

  @override
  List<Object?> get props => [profile];
}
