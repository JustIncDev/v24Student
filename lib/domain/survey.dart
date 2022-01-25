import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/user_profile.dart';

part 'survey.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class Survey extends DomainObject {
  Survey(
    String id,
    this.title,
    this.startTime,
    this.author,
  ) : super(id);

  final String? title;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime? startTime;
  final UserProfile? author;

  factory Survey.fromJson(Map<String, Object?> json) => _$SurveyFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SurveyToJson(this);
}

DateTime? dateTimeFromTimestamp(Timestamp? timestamp) {
  return timestamp?.toDate();
}
