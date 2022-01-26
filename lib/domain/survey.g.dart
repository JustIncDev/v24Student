// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) => Survey(
      json['id'] as String,
      json['title'] as String?,
      dateTimeFromTimestamp(json['startTime'] as Timestamp?),
      json['author'] == null
          ? null
          : UserProfile.fromJson(json['author'] as Map<String, dynamic>),
      json['status'] as String?,
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startTime': instance.startTime?.toIso8601String(),
      'author': instance.author?.toJson(),
      'status': instance.status,
    };
