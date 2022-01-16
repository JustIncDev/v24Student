import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/global/injector.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/defocuser.dart';
import 'package:v24_student_app/res/localization/app_localization.dart';
import 'package:v24_student_app/utils/session_state.dart';

import 'global/navigation/root_router.dart';

class V24StudentApplication extends StatefulWidget {
  const V24StudentApplication({
    Key? key,
    required this.injector,
  }) : super(key: key);

  final Injector injector;

  @override
  _V24StudentApplicationState createState() => _V24StudentApplicationState();
}

class _V24StudentApplicationState extends State<V24StudentApplication> {
  GlobalKey? providerKey;

  @override
  void initState() {
    super.initState();
    providerKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.injector.authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous.active != current.active,
        listenWhen: (oldState, newState) => oldState.active != newState.active,
        listener: (context, state) {
          providerKey = GlobalKey();
        },
        builder: (context, authState) {
          //Return splash screen
          // if (authState.isNotInit()) return Container();
          ScreenInfo _initScreenInfo;
          if (authState.active) {
            _initScreenInfo = const ScreenInfo(name: ScreenName.surveys);
          } else {
            if (!SessionState().getOnboardingFlag()) {
              _initScreenInfo = const ScreenInfo(name: ScreenName.onboarding);
            } else {
              _initScreenInfo = const ScreenInfo(name: ScreenName.login);
            }
          }
          return Provider<BlocFactory>(
            key: providerKey,
            create: (ctx) => BlocFactory(
              authBloc: BlocProvider.of<AuthBloc>(ctx),
            ),
            lazy: false,
            child: V24StudentBindingObserver(
              screenInfo: _initScreenInfo,
              authState: authState,
            ),
          );
        },
      ),
    );
  }
}

class V24StudentBindingObserver extends StatefulWidget {
  const V24StudentBindingObserver({
    Key? key,
    required this.screenInfo,
    required this.authState,
  }) : super(key: key);

  final ScreenInfo screenInfo;
  final AuthState authState;

  @override
  _V24StudentBindingObserverState createState() => _V24StudentBindingObserverState();
}

class _V24StudentBindingObserverState extends State<V24StudentBindingObserver>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Defocuser(
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        localizationsDelegates: [
          const TextResourceDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: RootRouter(initScreenInfo: widget.screenInfo),
      ),
    );
  }
}
