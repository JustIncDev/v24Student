// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSubject _$FavoriteSubjectFromJson(Map<String, dynamic> json) =>
    FavoriteSubject(
      json['id'] as String,
      json['title'] as String,
      json['imagePath'] as String,
      json['color'] as String,
      (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteSubjectToJson(FavoriteSubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imagePath': instance.imagePath,
      'color': instance.color,
      'subjects': instance.subjects,
    };

SubSubject _$SubSubjectFromJson(Map<String, dynamic> json) => SubSubject(
      json['id'] as String,
      json['subject'] as String,
    );

Map<String, dynamic> _$SubSubjectToJson(SubSubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
    };
