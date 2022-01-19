import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/domain/teacher.dart';
import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/favorite_remote_provider.dart';

class FavoriteRepo extends BaseRepo {
  FavoriteRepo()
      : _favoriteRemoteProvider = FavoriteRemoteProvider(),
        super();

  final FavoriteRemoteProvider _favoriteRemoteProvider;

  Future<List<FavoriteSubject>> getSubjectsList() {
    try {
      return _favoriteRemoteProvider.getMainSubjects();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<FavoriteTeacher>> getTeachersList() async {
    try {
      return _favoriteRemoteProvider.getTeachersList();
    } on Exception catch (e) {
      throw e;
    }
  }
}
