import 'package:v24_student_app/domain/base.dart';

class FavoriteSubject extends FavoriteObject {
  FavoriteSubject(
    String id,
    String title,
    String imagePath,
    int color,
    this.subSubjects,
  ) : super(id, title, imagePath, color);

  final List<String>? subSubjects;
}
