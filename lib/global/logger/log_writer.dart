import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:f_logs/utils/filters/filter_type.dart';
import 'package:f_logs/utils/filters/filters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:v24_student_app/utils/date.dart';

abstract class LogWriter {
  void log(String log);

  Future<File> saveToFile();

  Future<void> clear();

  Future<void> clearOlds();
}

class FileLogWriter implements LogWriter {
  FileLogWriter._() {
    FLog.applyConfigurations(LogsConfig()..isDebuggable = false);
    _eventStream = StreamController.broadcast();
    _queue = _eventStream.stream.asyncMap((event) async {
      return FLog.logThis(text: event, type: LogLevel.INFO);
    });
    _queue.drain();
  }

  static final FileLogWriter instance = FileLogWriter._();

  late Stream<void> _queue;
  late StreamController<String> _eventStream;

  @override
  void log(String log) {
    _eventStream.add(log);
  }

  @override
  Future<File> saveToFile() {
    var buffer = StringBuffer();
    var index = 0;
    return FLog.getAllLogsByFilter(filterType: FilterType.LAST_24_HOURS).then((logs) async {
      logs.forEach((log) {
        index++;
        buffer
          ..write('$index :    ')
          ..write(log.timestamp?.padLeft(30))
          ..write(' : ')
          ..writeln(log.text);
      });

      final outputDir = Platform.isAndroid ? await getTemporaryDirectory() : await getApplicationDocumentsDirectory();
      final path = '${outputDir.path}/logs';
      await Directory(path).create();

      final logFilePath = '$path/${_fileName}.log';
      final logFile = await File(logFilePath).writeAsString(buffer.toString());
      buffer.clear();

      final archiveFilePath = '${outputDir.path}/${_fileName}.zip';
      var encoder = ZipFileEncoder();
      encoder.create(archiveFilePath);
      encoder.addFile(logFile);
      encoder.close();

      logFile.deleteSync();

      return File(archiveFilePath);
    });
  }

  @override
  Future<void> clear() {
    return FLog.clearLogs();
  }

  @override
  Future<void> clearOlds() {
    return FLog.deleteAllLogsByFilter(
      filters: Filters.generateFilters(endTimeInMillis: DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch),
    );
  }

  static String get _fileName {
    return 'V24Teacher_${DateUtils.formatToFileDate(DateTime.now())}';
  }
}
