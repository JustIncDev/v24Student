part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends BaseBlocEvent {
  @override
  List<Object> get props => [];
}

class FavoriteInitEvent extends FavoriteEvent {}

class FavoriteSelectEvent extends FavoriteEvent {
  FavoriteSelectEvent(this.itemType, this.favoriteObject);

  final FavoriteItemType itemType;
  final FavoriteObject favoriteObject;
}

class FavoriteLoadSubSubjectEvent extends FavoriteEvent {
  FavoriteLoadSubSubjectEvent(this.mainSubjectId);

  final String mainSubjectId;
}

class FavoritePerformEvent extends FavoriteEvent {}

class FavoriteSuccessEvent extends FavoriteEvent {}

class FavoriteFailedEvent extends FavoriteEvent {}