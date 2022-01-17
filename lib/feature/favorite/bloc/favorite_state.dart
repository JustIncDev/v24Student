part of 'favorite_bloc.dart';

class FavoriteState extends BaseBlocState {
  FavoriteState({
    required this.favoriteTeachers,
    required this.favoriteSubjects,
    this.status,
  });

  FavoriteState.init()
      : this.favoriteTeachers = {},
        this.favoriteSubjects = {},
        this.status = BaseScreenStatus.input;

  final Map<FavoriteSubject, bool> favoriteSubjects;
  final Map<FavoriteTeacher, bool> favoriteTeachers;
  final BaseScreenStatus? status;

  FavoriteState copyWith({
    Map<FavoriteTeacher, bool>? favoriteTeachers,
    Map<FavoriteSubject, bool>? favoriteSubjects,
    BaseScreenStatus? status,
  }) {
    return FavoriteState(
      favoriteTeachers: favoriteTeachers ?? this.favoriteTeachers,
      favoriteSubjects: favoriteSubjects ?? this.favoriteSubjects,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [favoriteSubjects, favoriteTeachers, status];
}
