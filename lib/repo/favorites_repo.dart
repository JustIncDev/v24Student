import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/favorite_remote_provider.dart';

class FavoriteRepo extends BaseRepo {
  FavoriteRepo()
      : _favoriteRemoteProvider = FavoriteRemoteProvider(),
        super();

  final FavoriteRemoteProvider _favoriteRemoteProvider;

  Future<void> getSubjectsList() async {
    try {
      await _favoriteRemoteProvider.getSubjectsList();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> getTeachersList() async {
    try {
      await _favoriteRemoteProvider.getTeachersList();
    } on Exception catch (e) {
      throw e;
    }
  }
}
