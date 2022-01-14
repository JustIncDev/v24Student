// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseEmail _$FirebaseEmailFromJson(Map<String, dynamic> json) =>
    FirebaseEmail(
      json['email'] as String?,
      json['verified'] as bool?,
    );

Map<String, dynamic> _$FirebaseEmailToJson(FirebaseEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verified': instance.verified,
    };

FirebasePhone _$FirebasePhoneFromJson(Map<String, dynamic> json) =>
    FirebasePhone(
      json['phoneNumber'] as String?,
      json['verified'] as bool?,
    );

Map<String, dynamic> _$FirebasePhoneToJson(FirebasePhone instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'verified': instance.verified,
    };
