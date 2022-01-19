part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class FavoriteInitEvent extends FavoriteEvent {}

class FavoriteSelectTeacherEvent extends FavoriteEvent {
  FavoriteSelectTeacherEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FavoriteSelectSubjectEvent extends FavoriteEvent {
  FavoriteSelectSubjectEvent({
    required this.mainSubjectId,
  });

  final String mainSubjectId;
}

class FavoritePrepareLocalEvent extends FavoriteEvent {
  FavoritePrepareLocalEvent(this.mainSubjectId);

  final String mainSubjectId;
}

class FavoriteSelectSubSubjectLocalEvent extends FavoriteEvent {
  FavoriteSelectSubSubjectLocalEvent(this.id);

  final String id;
}

class FavoriteSelectAllSubSubjectsLocalEvent extends FavoriteEvent {
  FavoriteSelectAllSubSubjectsLocalEvent(this.item);

  final FavoriteSubject item;
}

class FavoritePerformEvent extends FavoriteEvent {}

class FavoriteSuccessEvent extends FavoriteEvent {}

class FavoriteFailedEvent extends FavoriteEvent {}
