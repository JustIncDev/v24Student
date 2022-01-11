import 'dart:async';

import 'package:flutter/widgets.dart';

StreamController<DataNotification> _dataNotificationsStream = StreamController.broadcast();

abstract class BaseRepo<N extends DataNotification> {
  BaseRepo() {
    _notificationStream = _dataNotificationsStream.stream.cast<N>().asBroadcastStream();
  }

  late Stream<N> _notificationStream;

  Stream<N> get dataNotificationStream => _notificationStream;

  @protected
  void emitDataNotification([DataNotification? dataNotification]) {
    _dataNotificationsStream.add(dataNotification ?? _notificationFabric<N>());
  }
}

abstract class DataNotification {}

DataNotification _notificationFabric<N extends DataNotification>() {
  throw ArgumentError();
}
