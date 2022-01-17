import 'package:v24_student_app/domain/base.dart';

class FavoriteTeacher extends FavoriteObject {
  FavoriteTeacher(
    String id,
    String title,
    String imagePath,
    int color,
  ) : super(id, title, imagePath, color);
}
