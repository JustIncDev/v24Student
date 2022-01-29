import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';


const _logMetadata = LogMetadata(
  className: 'ChildRouter',
  func: LogFunc.NAVIGATION,
  layer: LogLayer.UI,
  file: SourceFile('global/navigation/', 'child_router.dart'),
);

class _ChildRouterScope extends InheritedWidget {
  const _ChildRouterScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final ChildRouterState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class ChildRouter extends StatefulWidget {
  ChildRouter({
    Key? key,
    required this.name,
    required this.initScreenInfo,
    required this.backButtonDispatcher,
  }) : super(key: key);

  final String name;
  final ScreenInfo? initScreenInfo;
  final ChildBackButtonDispatcher? backButtonDispatcher;

  @override
  ChildRouterState createState() => ChildRouterState();

  static ChildRouterState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ChildRouterScope>())?.state;
  }
}

class ChildRouterState extends State<ChildRouter> with AutomaticKeepAliveClientMixin {
  late List<ScreenInfo> infoList;

  final GlobalKey<NavigatorState> childNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    infoList = widget.initScreenInfo != null ? [widget.initScreenInfo!] : [];
  }

  void first(ScreenInfo info) {
    Log.info('ChildRouter(${widget.name}) FIRST', params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
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

  Future<Object?> push(ScreenInfo info) {
    Log.info('ChildRouter(${widget.name}) PUSH', params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
    setState(() {
      _addScreenInfo(info);
    });
    if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
      return info.resultCompleter!.future;
    } else {
      return Future.value(null);
    }
  }

  void _addScreenInfo(ScreenInfo info) {
    if (infoList.contains(info)) {
      infoList.removeRange(infoList.indexOf(info), infoList.length);
    }
    infoList.add(info);
  }

  Future<dynamic> replace(ScreenInfo info) {
    Log.info('ChildRouter(${widget.name}) REPLACE', params: {'info': Log.screenInfoToLog(info)}, metadata: _logMetadata);
    setState(() {
      infoList.removeLast();
      infoList.add(info);
    });
    if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
      return info.resultCompleter!.future;
    } else {
      return Future.value(null);
    }
  }

  void pop({Object? result}) {
    Log.info('ChildRouter(${widget.name}) POP', metadata: _logMetadata);
    setState(() {
      if (infoList.isNotEmpty) {
        var info = infoList.removeLast();
        if (info.resultCompleter != null && !info.resultCompleter!.isCompleted) {
          info.resultCompleter!.future;
        }
      }
    });
  }

  @override
  void didUpdateWidget(ChildRouter oldWidget) {
    if (oldWidget.initScreenInfo == null || widget.initScreenInfo != oldWidget.initScreenInfo) {
      infoList = [widget.initScreenInfo!];
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _ChildRouterScope(
      state: this,
      child: Router(
        routerDelegate: ChildRouterDelegate(childNavKey),
        backButtonDispatcher: widget.backButtonDispatcher,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ChildRouterDelegate extends RouterDelegate<void> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  ChildRouterDelegate(this._navigatorKey, {this.name}) : super();

  final String? name;
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    final state = ChildRouter.of(context)!;
    return Navigator(
      key: _navigatorKey,
      pages: toPages(state.infoList, context),
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }
        state.pop();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async => null;

  List<Page<void>> toPages(List<ScreenInfo> infoList, BuildContext context) {
    return infoList.map<Page<void>>((info) {
      return toPage(info, context);
    }).toList();
  }
}
