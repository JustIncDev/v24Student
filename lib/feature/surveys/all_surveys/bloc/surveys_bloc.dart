import 'package:bloc/bloc.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/repo/surveys_repo.dart';

part 'surveys_event.dart';
part 'surveys_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  final SurveysRepo _surveysRepo;

  SurveysBloc({
    required SurveysRepo surveysRepo,
  })  : _surveysRepo = surveysRepo,
        super(SurveysState.init()) {
    on<SurveysEvent>((event, emit) async {
      if (event is SurveysInitEvent) {
        await _handleInitEvent(event, emit);
      } else if (event is SurveysSuccessEvent) {
        _handleSuccessEvent(event, emit);
      } else if (event is SurveysFailedEvent) {
        _handleFailedEvent(event, emit);
      }
    });
    add(SurveysInitEvent());
  }

  Future<void> _handleInitEvent(
    SurveysInitEvent event,
    Emitter<SurveysState> emit,
  ) async {
    var surveys = await _surveysRepo.getSurveyList();
    if (surveys != null) {
      emit(state.copyWith(surveyList: surveys, status: SurveyScreenStatus.loaded));
    } else {
      emit(state.copyWith(status: SurveyScreenStatus.loadFailed));
    }
  }

  void _handleSuccessEvent(
    SurveysSuccessEvent event,
    Emitter<SurveysState> emit,
  ) {}

  void _handleFailedEvent(
    SurveysFailedEvent event,
    Emitter<SurveysState> emit,
  ) {}
}
