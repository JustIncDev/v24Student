// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      firebaseEmail: json['firebaseEmail'] == null
          ? null
          : FirebaseEmail.fromJson(
              json['firebaseEmail'] as Map<String, dynamic>),
      firebasePhone: json['firebasePhone'] == null
          ? null
          : FirebasePhone.fromJson(
              json['firebasePhone'] as Map<String, dynamic>),
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      birthdayDate: json['birthdayDate'] as String?,
      password: json['password'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'firebaseEmail': instance.firebaseEmail?.toJson(),
      'firebasePhone': instance.firebasePhone?.toJson(),
      'country': instance.country,
      'gender': instance.gender,
      'birthdayDate': instance.birthdayDate,
      'password': instance.password,
      'avatarUrl': instance.avatarUrl,
    };
