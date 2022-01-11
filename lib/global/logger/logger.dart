import 'dart:io';
import 'package:v24_student_app/global/logger/log_writer.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';

class Log {
  static final LogWriter _logWriter = FileLogWriter.instance;

  static void initialize() {
    _logWriter.clearOlds();
  }

  static void temp(String mes, {LogMetadata? metadata, Map<String, Object>? params}) {
    write(level: LogLevel.TEMP, mes: mes, metadata: metadata, params: params);
  }

  static void debug(String mes, {LogMetadata? metadata, Map<String, Object>? params}) {
    write(level: LogLevel.DEBUG, mes: mes, metadata: metadata, params: params);
  }

  static void info(String mes, {LogMetadata? metadata, Map<String, Object>? params}) {
    write(level: LogLevel.INFO, mes: mes, metadata: metadata, params: params);
  }

  static void warn(String mes, {LogMetadata? metadata, Map<String, Object>? params}) {
    write(level: LogLevel.WARNING, mes: mes, metadata: metadata, params: params);
  }

  static void call(String method, {LogMetadata? metadata, Map<String, Object>? params}) {
    write(
        method: method,
        level: LogLevel.DEBUG,
        mes: 'CALL $method',
        metadata: metadata,
        params: params);
  }

  static void error(String message,
      {LogMetadata? metadata,
      Object? exc,
      StackTrace? stackTrace,
      Map<String, Object>? params,
      String? method}) {
    write(
        level: LogLevel.ERROR,
        method: method,
        metadata: metadata,
        mes: '$message: ${exc?.toString() ?? 'empty'}',
        params: {'exception': exc, 'stackTrace': stackTrace.toString()});
  }

  static void write(
      {String? level,
      String? mes,
      String? method,
      LogMetadata? metadata,
      Map<String, Object?>? params}) {
    if (level == LogLevel.DEBUG || level == LogLevel.TEMP) return;
    printToConsole(
        toHumanText(level: level, mes: mes, method: method, metadata: metadata, params: params));

    printToFile(
        toFileText(level: level, mes: mes, method: method, metadata: metadata, params: params));
  }

  static String toHumanText(
      {String? level,
      String? mes,
      String? method,
      LogMetadata? metadata,
      Map<String, Object?>? params}) {
    var outputMessage = 'MS-LOG($level): $mes';
    if (method != null) {
      outputMessage += '; #METHOD: $method';
    }
    if (params != null && params.isNotEmpty) {
      outputMessage += '; #PARAMS: ${_paramsToLog(params)}';
    }
    if (metadata != null) {
      outputMessage += '; #METADATA: ${metadata.toLog()}';
    }
    return outputMessage;
  }

  static String toFileText(
      {String? level,
      String? mes,
      String? method,
      LogMetadata? metadata,
      Map<String, Object?>? params}) {
    var paramsLog = '#PARAMS: empty;';
    if (params != null && params.isNotEmpty) {
      paramsLog = '#PARAMS: ${_paramsToLog(params)}';
    }
    return 'MS-LOG($level): $mes;  #METHOD: ${method ?? 'empty'}; $paramsLog; #METADATA: ${metadata?.toLog() ?? 'empty'}';
  }

  static String toParselableText(
      {String? level,
      String? mes,
      String? method,
      LogMetadata? metadata,
      Map<String, Object?>? params}) {
    var paramsLog = '#PARAMS: ';
    if (params != null && params.isNotEmpty) {
      paramsLog = '#PARAMS: ${_paramsToLog(params)}';
    }
    return '#LOG: ${DateTime.now().millisecondsSinceEpoch} #LEVEL: $level #MESS: $mes #METHOD: $method ${metadata?.toLog()} $paramsLog #END:';
  }

  static String _paramsToLog(Map<String, Object?> params) {
    var text = '';
    for (var key in params.keys) {
      text += '$key <=> ${params[key]} <;> ';
    }
    return text;
  }

  static void printToFile(String log) {
    _logWriter.log(log);
  }

  static Future<File> exportFile() {
    return _logWriter.saveToFile();
  }

  static Future<void> clear() {
    return _logWriter.clear();
  }

  static void printToConsole(String log) {
    var defaultPrintLength = 900;
    if (log.length <= defaultPrintLength) {
      print(log);
    } else {
      var start = 0;
      var endIndex = defaultPrintLength;
      var logLength = log.length;
      var tmpLogLength = log.length;
      while (endIndex < logLength) {
        print('${start == 0 ? '' : '-> '} ${log.substring(start, endIndex)}');
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print('${start == 0 ? '' : '-> '} ${log.substring(start, logLength)}');
      }
    }
  }

  static String screenInfoToLog(ScreenInfo screenInfo) {
    if (screenInfo.name == ScreenName.login) {
      return '${screenInfo.name} [params: hidden]';
    } else {
      return '${screenInfo.name} [params: ${screenInfo.params.toString()}]';
    }
  }
}

class LogMetadata {
  const LogMetadata({
    this.file,
    this.className,
    this.layer,
    this.func,
  });

  final SourceFile? file;
  final String? className;
  final String? layer;
  final String? func;

  String toLog() {
    return '#LAYER: $layer #FUNC: $func #CLASS: $className  ${file?.toLog()} ';
  }
}

class SourceFile {
  const SourceFile(this.package, this.file);

  final String package;
  final String file;

  String toLog() {
    return '#PACKAGE: $package #FILE: $file';
  }
}

class LogLayer {
  static const String BLOC = 'BLOC';
  static const String REPO = 'REPO';
  static const String UI = 'UI';
  static const String DB = 'DB';
  static const String API = 'API';
  static const String UTILS = 'UTILS';
  static const String REQUEST = 'REQUEST';
  static const String RESPONSE = 'RESPONSE';
  static const String OTHER = 'OTHER';
}

class LogFunc {
  static const String NAVIGATION = 'NAVIGATION';
  static const String COMMON = 'COMMON';
  static const String PROFILE = 'PROFILE';
  static const String LOGIN = 'LOGIN';
  static const String HOME = 'HOME';
}

class LogLevel {
  static const String TEMP = 'TEMP';
  static const String DEBUG = 'DEBUG';
  static const String INFO = 'INFO';
  static const String WARNING = 'WARNING';
  static const String ERROR = 'ERROR';
}
