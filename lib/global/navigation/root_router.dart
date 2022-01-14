import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';

const _logMetadata = LogMetadata(
  className: 'RootRouter',
  func: LogFunc.NAVIGATION,
  layer: LogLayer.UI,
  file: SourceFile('global/navigation/', 'root_router.dart'),
);

class _RootRouterScope extends InheritedWidget {
  const _RootRouterScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final RootRouterState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class RootRouter extends StatefulWidget {
  RootRouter({
    Key? key,
    required this.initScreenInfo,
  }) : super(key: key);

  final ScreenInfo initScreenInfo;

  @override
  RootRouterState createState() => RootRouterState();

  static RootRouterState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_RootRouterScope>())?.state;
  }
}

class RootRouterState extends State<RootRouter> with AutomaticKeepAliveClientMixin {
  late List<ScreenInfo> infoList;
  late GlobalKey<NavigatorState> rootNavKey;
  final RootBackButtonDispatcher rootBackButtonDispatcher = RootBackButtonDispatcher();

  @override
  void initState() {
    infoList = [widget.initScreenInfo];
    rootNavKey = GlobalKey<NavigatorState>();
    super.initState();
  }

  @override
  void didUpdateWidget(RootRouter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.initScreenInfo, oldWidget.initScreenInfo)) {
      infoList = [widget.initScreenInfo];
    }
  }

  void first(ScreenInfo info) {
    Log.info('RootRouter FIRST',
        params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
    setState(() {
      infoList.reversed.forEach((info) {
        if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
          info.resultCompleter!.complete(null);
        }
      });
      infoList.clear();
      infoList.add(info);
    });
  }

  Future<Object?> push(ScreenInfo info, {bool replacement = false}) {
    Log.info('RootRouter PUSH',
        params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
    setState(() {
      if (replacement) {
        infoList.clear();
      }
      infoList.add(info);
    });
    if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
      return info.resultCompleter!.future;
    } else {
      return Future.value(null);
    }
  }

  void pop({Object? result}) {
    Log.info('RootRouter POP', metadata: _logMetadata);
    setState(() {
      if (infoList.isNotEmpty) {
        var info = infoList.removeLast();
        if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
          info.resultCompleter!.complete(result);
        }
      }
    });
  }

  void popUntil(ScreenInfo info) {
    Log.info('RootRouter POP UNTIL',
        params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
    setState(() {
      var removableInfoElements = <ScreenInfo>[];
      if (infoList.isNotEmpty) {
        for (var infoElement in infoList.reversed) {
          if (infoElement.resultCompleter != null && !infoElement.resultCompleter!.isCompleted) {
            infoElement.resultCompleter!.complete(null);
          }
          if (infoElement != info) {
            removableInfoElements.add(infoElement);
          } else {
            break;
          }
        }
        infoList.removeWhere((element) => removableInfoElements.contains(element));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          return previous.active != current.active;
        },
        listener: (context, authState) {
          if (authState.active) {
            first(ScreenInfo(
              //Change to main screen
              name: ScreenName.login,
              params: {'bbDispatcher': rootBackButtonDispatcher},
            ));
          } else {
            first(const ScreenInfo(name: ScreenName.login));
          }
        },
        child: _RootRouterScope(
          state: this,
          child: Router(
            routerDelegate: RootRouterDelegate(rootNavKey),
            backButtonDispatcher: rootBackButtonDispatcher,
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class RootRouterDelegate extends RouterDelegate<void>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  RootRouterDelegate(this.rootNavKey) : super();

  final GlobalKey<NavigatorState> rootNavKey;

  @override
  Widget build(BuildContext context) {
    final state = RootRouter.of(context)!;
    return Navigator(
      key: rootNavKey,
      pages: toPages(state.infoList, context),
      onPopPage: (route, Object? result) {
        if (!route.didPop(result)) {
          return false;
        }
        RootRouter.of(context)!.pop();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => rootNavKey;

  @override
  Future<void> setNewRoutePath(configuration) async => null;

  List<Page<void>> toPages(List<ScreenInfo> infoList, BuildContext context) {
    return infoList.map<Page<void>>((info) {
      return toPage(info, context);
    }).toList();
  }
}
