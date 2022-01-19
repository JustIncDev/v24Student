import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v24_student_app/domain/base.dart';

part 'teacher.g.dart';

@JsonSerializable()
@immutable
class FavoriteTeacher extends FavoriteObject {
  FavoriteTeacher(
    String id,
    String title,
    String? imagePath,
    String? color,
  ) : super(id, title, imagePath, color);

  factory FavoriteTeacher.fromJson(Map<String, Object?> json) => _$FavoriteTeacherFromJson(json);

  @override
  Map<String, Object?> toJson() => _$FavoriteTeacherToJson(this);
}
