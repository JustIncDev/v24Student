import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/base.dart';

part 'subject.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class FavoriteSubject extends FavoriteObject {
  FavoriteSubject(
    String id,
    String title,
    String imagePath,
    String color,
  ) : super(id, title, imagePath, color);

  factory FavoriteSubject.fromJson(Map<String, Object?> json) => _$FavoriteSubjectFromJson(json);

  @override
  Map<String, Object?> toJson() => _$FavoriteSubjectToJson(this);
}

@JsonSerializable()
@immutable
class SubSubject extends DomainObject {
  SubSubject(
    String id,
    this.subject,
  ) : super(id);

  factory SubSubject.fromJson(Map<String, Object?> json) => _$SubSubjectFromJson(json);

  final String subject;

  @override
  Map<String, Object?> toJson() => _$SubSubjectToJson(this);
}
