import 'package:flutter/foundation.dart';
import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/utils/session_state.dart';

import '../../bloc.dart';

@immutable
abstract class AuthEvent extends BaseBlocEvent {
  @override
  List<Object?> get props => [];
}

@immutable
class AuthInitedEvent extends AuthEvent {}

@immutable
class AuthUpdateEvent extends AuthEvent {
  AuthUpdateEvent({this.afterSignUp});

  final bool? afterSignUp;

  @override
  List<Object?> get props => [afterSignUp];
}

@immutable
class AuthLogoutPerformEvent extends AuthEvent {
  AuthLogoutPerformEvent();

  @override
  List<Object> get props => [];
}

class AuthState extends BaseBlocState {
  AuthState({
    this.inited = false,
    this.active = false,
    this.pinConfigured = false,
    this.afterSignUp = false,
  });

  AuthState.empty()
      : inited = false,
        active = false,
        pinConfigured = false,
        afterSignUp = false;

  AuthState.toChange({
    required bool active,
    bool? afterSignUp,
    bool? pinConfigured,
  })  : inited = true,
        active = active,
        pinConfigured = pinConfigured ?? false,
        afterSignUp = afterSignUp ?? false;

  final bool inited;
  final bool active;
  final bool pinConfigured;
  final bool afterSignUp;

  bool isNotInit() => !inited;

  @override
  List<Object?> get props => [inited, active, pinConfigured];
}

class AuthBloc extends DataBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.empty()) {
    on<AuthEvent>((event, emit) {
      if (event is AuthInitedEvent) {
        emit(AuthState.toChange(
          active: _isActive(),
          pinConfigured: _isPinConfigured(),
        ));
      } else if (event is AuthUpdateEvent) {
        emit(AuthState.toChange(
          active: _isActive(),
          pinConfigured: _isPinConfigured(),
        ));
      } else if (event is AuthLogoutPerformEvent) {
        _logout();
      }
    });
  }

  @override
  Future<void> init() async {
    add(AuthInitedEvent());
  }

  bool _isActive() {
    var userId = SessionState().getUserId();
    return userId != null && userId.isNotEmpty;
  }

  bool _isPinConfigured() {
    return SessionState().pinConfigured() ?? false;
  }

  void _logout() {
    Future.wait<Object?>([
      SessionState().clearSessionData(),
    ]).then((values) {
      Log.info('logout success');
      add(AuthUpdateEvent());
    });
  }
}
