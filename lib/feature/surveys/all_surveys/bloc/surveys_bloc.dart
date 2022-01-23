import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'surveys_event.dart';
part 'surveys_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  SurveysBloc() : super(SurveysInitial()) {
    on<SurveysEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
