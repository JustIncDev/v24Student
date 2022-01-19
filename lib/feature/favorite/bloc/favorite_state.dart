part of 'favorite_bloc.dart';

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
        this.selectedSubjects = [],
        this.selectedTeachers = [],
        this.status = BaseScreenStatus.input;

  final List<FavoriteSubject> favoriteSubjects;
  final List<FavoriteTeacher> favoriteTeachers;
  final List<String> selectedSubjects;
  final List<String> selectedTeachers;
  final BaseScreenStatus? status;

  FavoriteState copyWith({
    List<FavoriteTeacher>? favoriteTeachers,
    List<FavoriteSubject>? favoriteSubjects,
    List<String>? selectedSubjects,
    List<String>? selectedTeachers,
    BaseScreenStatus? status,
  }) {
    return FavoriteState(
      favoriteTeachers: favoriteTeachers ?? this.favoriteTeachers,
      favoriteSubjects: favoriteSubjects ?? this.favoriteSubjects,
      selectedTeachers: selectedTeachers ?? this.selectedTeachers,
      selectedSubjects: selectedSubjects ?? this.selectedSubjects,
      status: status ?? this.status,
    );
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
