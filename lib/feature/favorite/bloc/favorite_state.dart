part of 'favorite_bloc.dart';

enum FavoriteScreenStatus { input, lock, next, back, subSubjectsLoading }

class FavoriteState extends BaseBlocState {
  FavoriteState({
    required this.favoriteTeachers,
    required this.favoriteSubjects,
    required this.selectedTeachers,
    required this.selectedSubjects,
    this.status,
  });

  FavoriteState.init()
      : this.favoriteTeachers = [],
        this.favoriteSubjects = [],
        this.selectedSubjects = {},
        this.selectedTeachers = [],
        this.status = FavoriteScreenStatus.input;

  final List<FavoriteSubject> favoriteSubjects;
  final List<FavoriteTeacher> favoriteTeachers;
  final Map<String, List<String>> selectedSubjects;
  final List<String> selectedTeachers;
  final FavoriteScreenStatus? status;

  FavoriteState copyWith({
    List<FavoriteTeacher>? favoriteTeachers,
    List<FavoriteSubject>? favoriteSubjects,
    Map<String, List<String>>? selectedSubjects,
    List<String>? selectedTeachers,
    FavoriteScreenStatus? status,
  }) {
    return FavoriteState(
      favoriteTeachers: favoriteTeachers ?? this.favoriteTeachers,
      favoriteSubjects: favoriteSubjects ?? this.favoriteSubjects,
      selectedTeachers: selectedTeachers ?? this.selectedTeachers,
      selectedSubjects: selectedSubjects ?? this.selectedSubjects,
      status: status ?? this.status,
    );
  }

  bool isSelected(String id, FavoriteItemType type) {
    if (type == FavoriteItemType.teacher) {
      return selectedTeachers.contains(id);
    } else {
      return selectedSubjects.containsKey(id);
    }
  }

  int selectedSubSubjectsCount(String mainSubjectId) {
    return selectedSubjects[mainSubjectId]?.length ?? 0;
  }

  bool isSubSubjectSelected(String mainSubjectId, String subSubjectId) {
    return selectedSubjects[mainSubjectId]?.contains(subSubjectId) ?? false;
  }

  @override
  List<Object?> get props => [
        favoriteSubjects,
        favoriteTeachers,
        selectedSubjects,
        selectedTeachers,
        status,
      ];
}
