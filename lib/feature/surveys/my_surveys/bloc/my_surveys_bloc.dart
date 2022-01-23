import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_surveys_event.dart';
part 'my_surveys_state.dart';

class MySurveysBloc extends Bloc<MySurveysEvent, MySurveysState> {
  MySurveysBloc() : super(MySurveysInitial()) {
    on<MySurveysEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
