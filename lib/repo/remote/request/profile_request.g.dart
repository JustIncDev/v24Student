// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequest _$EditProfileRequestFromJson(Map<String, dynamic> json) =>
    EditProfileRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      firebaseEmail: json['firebaseEmail'] == null
          ? null
          : FirebaseEmail.fromJson(
              json['firebaseEmail'] as Map<String, dynamic>),
      country: json['country'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$EditProfileRequestToJson(EditProfileRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'firebaseEmail': instance.firebaseEmail,
    };
