// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteTeacher _$FavoriteTeacherFromJson(Map<String, dynamic> json) =>
    FavoriteTeacher(
      json['id'] as String,
      json['title'] as String,
      json['imagePath'] as String?,
      json['color'] as String?,
    );

Map<String, dynamic> _$FavoriteTeacherToJson(FavoriteTeacher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imagePath': instance.imagePath,
      'color': instance.color,
    };
