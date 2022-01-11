import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/utils/session_state.dart';

class Injector {
  late AuthBloc _authBloc;

  Future<Injector> init() async {
    _authBloc = AuthBloc();

    return Future.wait([
      SessionState().initialize(),
      _authBloc.init(),
    ]).then((value) => this);
  }

  AuthBloc get authBloc => _authBloc;
}
