part of 'surveys_bloc.dart';

abstract class SurveysEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class SurveysInitEvent extends SurveysEvent {}

class SurveysSuccessEvent extends SurveysEvent {}

class SurveysFailedEvent extends SurveysEvent {}
