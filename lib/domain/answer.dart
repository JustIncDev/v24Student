import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/user_profile.dart';

import 'base.dart';

part 'answer.g.dart';

@JsonSerializable()
@immutable
class Answer extends DomainObject {
  Answer(
      String id,
      this.answer,
      this.student,
      ) : super(id);

  final String answer;
  final UserProfile student;

  factory Answer.fromJson(Map<String, Object?> json) => _$AnswerFromJson(json);

  @override
  Map<String, Object?> toJson() => _$AnswerToJson(this);
}
