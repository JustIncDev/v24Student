part of 'my_surveys_bloc.dart';

abstract class MySurveysEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

class MySurveysInitEvent extends MySurveysEvent {}

class MySurveysSuccessEvent extends MySurveysEvent {}

class MySurveysUpdateEvent extends MySurveysEvent {}

class MySurveysFailedEvent extends MySurveysEvent {}
