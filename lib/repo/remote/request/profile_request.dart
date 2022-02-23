import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/base.dart';

part 'profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.firebaseEmail,
    this.country,
    this.profilePicture,
  });

  factory EditProfileRequest.fromJson(Map<String, Object> json) => _$EditProfileRequestFromJson(json);

  final String? firstName;
  final String? lastName;
  final String? country;
  final String? profilePicture;
  final FirebaseEmail? firebaseEmail;

  Map<String, Object?> toJson() => _$EditProfileRequestToJson(this);
}
