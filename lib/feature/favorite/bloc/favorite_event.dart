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
    this.subSubjectId,
    this.selectAll = false,
  });

  final String mainSubjectId;
  final String? subSubjectId;
  final bool selectAll;
}

class FavoritePerformEvent extends FavoriteEvent {}

class FavoriteSuccessEvent extends FavoriteEvent {}

class FavoriteFailedEvent extends FavoriteEvent {}
