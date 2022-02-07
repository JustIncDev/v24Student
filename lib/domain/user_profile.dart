import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:v24_student_app/domain/base.dart';

part 'user_profile.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class UserProfile extends DomainObject {
  UserProfile({
    required String? id,
    this.firstName,
    this.lastName,
    this.firebaseEmail,
    this.firebasePhone,
    this.country,
    this.gender,
    this.birthdayDate,
    this.password,
    this.profilePicture,
  }) : super(id ?? const Uuid().v4());

  factory UserProfile.fromJson(Map<String, Object?> json) => _$UserProfileFromJson(json);

  final String? firstName;
  final String? lastName;
  final FirebaseEmail? firebaseEmail;
  final FirebasePhone? firebasePhone;
  final String? country;
  final String? gender;
  final String? birthdayDate;
  final String? password;
  final String? profilePicture;

  @override
  Map<String, Object?> toJson() => _$UserProfileToJson(this);
}
