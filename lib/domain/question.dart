import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/base.dart';

part 'question.g.dart';

@JsonSerializable()
@immutable
class Question extends DomainObject {
  Question(
      String id,
      this.index,
      this.question,
      ) : super(id);

  final int index;
  final String question;

  factory Question.fromJson(Map<String, Object?> json) => _$QuestionFromJson(json);

  @override
  Map<String, Object?> toJson() => _$QuestionToJson(this);
}
