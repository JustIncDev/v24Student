import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/repo/surveys_repo.dart';

part 'my_surveys_event.dart';
part 'my_surveys_state.dart';

class MySurveysBloc extends Bloc<MySurveysEvent, MySurveysState> {
  final SurveysRepo _surveysRepo;

  MySurveysBloc({
    required SurveysRepo surveysRepo,
  })  : _surveysRepo = surveysRepo,
        super(MySurveysState.init()) {
    on<MySurveysEvent>((event, emit) async {
      if (event is MySurveysInitEvent) {
        await _handleInitEvent(event, emit);
      } else if (event is MySurveysSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is MySurveysFailedEvent) {
        _handleFailedEvent(event, emit);
      } else if (event is MySurveysUpdateEvent) {
        await _handleUpdateEvent(event, emit);
      }
    });
    add(MySurveysInitEvent());
  }

  Future<void> _handleInitEvent(
    MySurveysInitEvent event,
    Emitter<MySurveysState> emit,
  ) async {
    var surveys = await _surveysRepo.getMySurveys();
    if (surveys != null) {
      emit(state.copyWith(newSurveyList: surveys, status: MySurveyScreenStatus.loaded));
    } else {
      emit(state.copyWith(status: MySurveyScreenStatus.loadFailed));
    }
  }

  Future<void> _handleUpdateEvent(
    MySurveysUpdateEvent event,
    Emitter<MySurveysState> emit,
  ) async {
    emit(state.copyWith(status: MySurveyScreenStatus.loading));
    var surveys = await _surveysRepo.getMySurveys();
    if (surveys != state.mySurveyList) {
      emit(state.copyWith(newSurveyList: surveys, status: MySurveyScreenStatus.loaded));
    } else {
      emit(state.copyWith(status: MySurveyScreenStatus.loaded));
    }
  }

  void _handleSuccessEvent(
    MySurveysSuccessEvent event,
    Emitter<MySurveysState> emit,
  ) {}

  void _handleFailedEvent(
    MySurveysFailedEvent event,
    Emitter<MySurveysState> emit,
  ) {}
}
