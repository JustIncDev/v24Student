import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/domain/teacher.dart';
import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/favorite_remote_provider.dart';

///Repo for favorite feature
class FavoriteRepo extends BaseRepo {
  FavoriteRepo()
      : _favoriteRemoteProvider = FavoriteRemoteProvider(),
        super();

  final FavoriteRemoteProvider _favoriteRemoteProvider;

  Future<List<FavoriteSubject>> getSubjectsList() async {
    try {
      var mainSubjects = await _favoriteRemoteProvider.getMainSubjects();
      var finalSubjectList = <FavoriteSubject>[];
      mainSubjects.forEach((element) async {
        var subSubjects = await _favoriteRemoteProvider.getSubSubjectList(element.id);
        finalSubjectList.add(FavoriteSubject(
          element.id,
          element.title,
          element.imagePath ?? '',
          element.color ?? '',
          subSubjects,
        ));
      });
      return finalSubjectList;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<FavoriteTeacher>> getTeachersList() {
    try {
      return _favoriteRemoteProvider.getTeachersList();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<bool> saveFavoriteData(
    Map<String, List<String>>? selectedSubjects,
    List<String>? selectedTeachers,
  ) {
    return _favoriteRemoteProvider.saveFavoriteData(selectedSubjects, selectedTeachers);
  }
}
