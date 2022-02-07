part of 'profile_bloc.dart';

class ProfileState extends BaseBlocState {
  ProfileState({
    this.avatarUrl,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.status = BaseScreenStatus.input,
  });

  final String? avatarUrl;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final BaseScreenStatus status;

  ProfileState copyWith({
    String? avatarUrl,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    BaseScreenStatus? status,
  }) {
    return ProfileState(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        avatarUrl,
        firstName,
        lastName,
        phoneNumber,
        email,
        status,
      ];
}
