import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/utils/session_state.dart';

class Injector {
  late AuthBloc _authBloc;
  ///Init Injector and dependencies
  Future<Injector> init() async {
    _authBloc = AuthBloc();
    await SessionState().initialize();
    await _authBloc.init();
    return this;
  }

  AuthBloc get authBloc => _authBloc;
}
