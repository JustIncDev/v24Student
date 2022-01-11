import 'package:intl/intl.dart';

final DateFormat _fileDate = DateFormat('yyyy_MM_dd');
final DateFormat _fullDayFormat = DateFormat('MMMM d, yyyy');

class DateUtils {
  static String formatToFileDate(DateTime dt) => _fileDate.format(dt);

  static String formatToFullDay(int timestamp) {
    return _fullDayFormat.format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
  }
}