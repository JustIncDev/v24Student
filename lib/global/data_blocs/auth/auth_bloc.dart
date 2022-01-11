import 'package:flutter/foundation.dart';
import 'package:v24_student_app/global/logger/logger.dart';

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
  AuthState({this.inited = false, this.active = false, this.afterSignUp = false});

  AuthState.empty()
      : inited = false,
        active = false,
        afterSignUp = false;

  AuthState.toChange({required bool active, bool? afterSignUp})
      : inited = true,
        active = active,
        afterSignUp = afterSignUp ?? false;

  final bool inited;
  final bool active;
  final bool afterSignUp;

  bool isNotInit() => !inited;

  @override
  List<Object?> get props => [inited, active];
}

class AuthBloc extends DataBloc<AuthEvent, AuthState> {
  // AuthBloc({required this.appParamRepo, required this.database}) : super(AuthState.empty());
  AuthBloc() : super(AuthState.empty());

  // final AppParamRepo appParamRepo;
  // final AppDatabase database;

  @override
  Future<void> init() async {
    // Authorizer.init(
    //   appParamRepo: appParamRepo,
    //   onUnauthorized: () => add(AuthLogoutPerformEvent()),
    // ).then(
    //       (authorizer) => add(AuthInitedEvent()),
    // );
  }

  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is AuthInitedEvent) {
  //     yield AuthState.toChange(active: Authorizer.instance.isActive());
  //   } else if (event is AuthUpdateEvent) {
  //     yield AuthState.toChange(active: Authorizer.instance.isActive(), afterSignUp: event.afterSignUp);
  //   } else if (event is AuthLogoutPerformEvent) {
  //     _logout();
  //   }
  // }

  void _logout() {
    Future.wait<dynamic>([
      // Authorizer.instance.clearTokens(),
      // appParamRepo.remove(AppParamId.firstLaunched),
      // appParamRepo.remove(AppParamId.apnsToken),
      // appParamRepo.remove(AppParamId.pendingNotifications),
    ]).then((values) {
      Log.info('logout success');
      add(AuthUpdateEvent());
    });
  }
}
