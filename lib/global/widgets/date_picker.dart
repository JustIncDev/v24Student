import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_holo_date_picker/date_picker_constants.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/date_time_formatter.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:v24_student_app/res/colors.dart';

/// Solar months of 31 days.
const List<int> _solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];

/// DatePicker widget.
class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    Key? key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = DATETIME_PICKER_DATE_FORMAT,
    this.locale = DATETIME_PICKER_LOCALE_DEFAULT,
    this.pickerTheme = DateTimePickerTheme.Default,
    this.onCancel,
    this.onChange,
    this.onConfirm,
    this.looping = false,
  }) : super(key: key) {
    var minTime = firstDate ?? DateTime.parse(DATE_PICKER_MIN_DATETIME);
    var maxTime = lastDate ?? DateTime.parse(DATE_PICKER_MAX_DATETIME);
    assert(minTime.compareTo(maxTime) < 0);
  }

  final DateTime? firstDate, lastDate, initialDate;
  final String? dateFormat;
  final DateTimePickerLocale? locale;
  final DateTimePickerTheme? pickerTheme;

  final DateVoidCallback? onCancel;
  final DateValueCallback? onChange, onConfirm;
  final bool looping;

  @override
  State<StatefulWidget> createState() =>
      _CustomDatePickerState(this.firstDate, this.lastDate, this.initialDate);
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _minDateTime, _maxDateTime;
  int? _currYear, _currMonth, _currDay;
  List<int>? _yearRange, _monthRange, _dayRange;
  FixedExtentScrollController? _yearScrollCtrl, _monthScrollCtrl, _dayScrollCtrl;

  late Map<String, FixedExtentScrollController?> _scrollCtrlMap;
  late Map<String, List<int>?> _valueRangeMap;

  bool _isChangeDateRange = false;

  _CustomDatePickerState(DateTime? minDateTime, DateTime? maxDateTime, DateTime? initialDateTime) {
    // handle current selected year、month、day
    var initDateTime = initialDateTime ?? DateTime.now();
    this._currYear = initDateTime.year;
    this._currMonth = initDateTime.month;
    this._currDay = initDateTime.day;

    // handle DateTime range
    this._minDateTime = minDateTime ?? DateTime.parse(DATE_PICKER_MIN_DATETIME);
    this._maxDateTime = maxDateTime ?? DateTime.parse(DATE_PICKER_MAX_DATETIME);

    // limit the range of year
    this._yearRange = _calcYearRange();
    this._currYear = min(max(_minDateTime.year, _currYear!), _maxDateTime.year);

    // limit the range of month
    this._monthRange = _calcMonthRange();
    this._currMonth = min(max(_monthRange!.first, _currMonth!), _monthRange!.last);

    // limit the range of day
    this._dayRange = _calcDayRange();
    this._currDay = min(max(_dayRange!.first, _currDay!), _dayRange!.last);

    // create scroll controller
    _yearScrollCtrl = FixedExtentScrollController(initialItem: _currYear! - _yearRange!.first);
    _monthScrollCtrl = FixedExtentScrollController(initialItem: _currMonth! - _monthRange!.first);
    _dayScrollCtrl = FixedExtentScrollController(initialItem: _currDay! - _dayRange!.first);

    _scrollCtrlMap = {'y': _yearScrollCtrl, 'M': _monthScrollCtrl, 'd': _dayScrollCtrl};
    _valueRangeMap = {'y': _yearRange, 'M': _monthRange, 'd': _dayRange};
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.7,
        decoration: const BoxDecoration(),
        // padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
        child: GestureDetector(
          child: Material(color: Colors.transparent, child: _renderPickerView(context)),
        ),
      ),
    );
  }

  /// render date picker widgets
  Widget _renderPickerView(BuildContext context) {
    var datePickerWidget = _renderDatePickerWidget();

    return datePickerWidget;
  }

  /// notify selected date changed
  void _onSelectedChange() {
    if (widget.onChange != null) {
      var dateTime = DateTime(_currYear!, _currMonth!, _currDay!);
      widget.onChange!(dateTime, _calcSelectIndexList());
    }
  }

  /// find scroll controller by specified format
  FixedExtentScrollController? _findScrollCtrl(String format) {
    FixedExtentScrollController? scrollCtrl;
    _scrollCtrlMap.forEach((key, value) {
      if (format.contains(key)) {
        scrollCtrl = value;
      }
    });
    return scrollCtrl;
  }

  /// find item value range by specified format
  List<int>? _findPickerItemRange(String format) {
    List<int>? valueRange;
    _valueRangeMap.forEach((key, value) {
      if (format.contains(key)) {
        valueRange = value;
      }
    });
    return valueRange;
  }

  /// render the picker widget of year、month and day
  Widget _renderDatePickerWidget() {
    var pickers = <Widget>[];
    var formatArr = DateTimeFormatter.splitDateFormat(widget.dateFormat);
    formatArr.forEach((format) {
      var valueRange = _findPickerItemRange(format)!;

      var pickerColumn = _renderDatePickerColumnComponent(
          scrollCtrl: _findScrollCtrl(format),
          valueRange: valueRange,
          format: format,
          valueChanged: (value) {
            if (format.contains('y')) {
              _changeYearSelection(value);
            } else if (format.contains('M')) {
              _changeMonthSelection(value);
            } else if (format.contains('d')) {
              _changeDaySelection(value);
            }
          },
          fontSize: widget.pickerTheme!.itemTextStyle.fontSize ?? sizeByFormat(widget.dateFormat!));
      pickers.add(pickerColumn);
    });
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: pickers);
  }

  Widget _renderDatePickerColumnComponent(
      {required FixedExtentScrollController? scrollCtrl,
      required List<int> valueRange,
      required String format,
      required ValueChanged<int> valueChanged,
      double? fontSize}) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 7, vertical: 18),
              height: 180.0,
              decoration: BoxDecoration(color: widget.pickerTheme!.backgroundColor),
              child: CupertinoPicker(
                selectionOverlay: Container(
                  color: AppColors.royalBlue.withOpacity(0.3),
                ),
                backgroundColor: widget.pickerTheme!.backgroundColor,
                scrollController: scrollCtrl,
                squeeze: 0.95,
                diameterRatio: 1.5,
                itemExtent: widget.pickerTheme!.itemHeight,
                onSelectedItemChanged: valueChanged,
                looping: widget.looping,
                children: List<Widget>.generate(
                  valueRange.last - valueRange.first + 1,
                  (index) {
                    return _renderDatePickerItemComponent(
                      valueRange.first + index,
                      format,
                      fontSize,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double sizeByFormat(String format) {
    if (format.contains('-MMMM') || format.contains('MMMM-')) {
      return DATETIME_PICKER_ITEM_TEXT_SIZE_SMALL;
    }

    return DATETIME_PICKER_ITEM_TEXT_SIZE_BIG;
  }

  Widget _renderDatePickerItemComponent(int value, String format, double? fontSize) {
    var weekday = DateTime(_currYear!, _currMonth!, value).weekday;

    return Column(
      children: [
        Container(
          height: widget.pickerTheme!.itemHeight,
          alignment: Alignment.center,
          child: AutoSizeText(
            DateTimeFormatter.formatDateTime(value, format, widget.locale, weekday),
            maxLines: 1,
            style: widget.pickerTheme?.itemTextStyle ?? DATETIME_PICKER_ITEM_TEXT_STYLE,
          ),
        ),
        // const Divider(thickness: 1,),
      ],
    );
  }

  /// change the selection of year picker
  void _changeYearSelection(int index) {
    var year = _yearRange!.first + index;
    if (_currYear != year) {
      _currYear = year;
      _changeDateRange();
      _onSelectedChange();
    }
  }

  /// change the selection of month picker
  void _changeMonthSelection(int index) {
    var month = _monthRange!.first + index;
    if (_currMonth != month) {
      _currMonth = month;
      _changeDateRange();
      _onSelectedChange();
    }
  }

  /// change the selection of day picker
  void _changeDaySelection(int index) {
    if (_isChangeDateRange) {
      return;
    }

    var dayOfMonth = _dayRange!.first + index;
    if (_currDay != dayOfMonth) {
      _currDay = dayOfMonth;
      _onSelectedChange();
    }
  }

  /// change range of month and day
  void _changeDateRange() {
    if (_isChangeDateRange) {
      return;
    }
    _isChangeDateRange = true;

    var monthRange = _calcMonthRange();
    var monthRangeChanged =
        _monthRange!.first != monthRange.first || _monthRange!.last != monthRange.last;
    if (monthRangeChanged) {
      // selected year changed
      _currMonth = max(min(_currMonth!, monthRange.last), monthRange.first);
    }

    var dayRange = _calcDayRange();
    var dayRangeChanged = _dayRange!.first != dayRange.first || _dayRange!.last != dayRange.last;
    if (dayRangeChanged) {
      // day range changed, need limit the value of selected day
      _currDay = max(min(_currDay!, dayRange.last), dayRange.first);
    }

    setState(() {
      _monthRange = monthRange;
      _dayRange = dayRange;

      _valueRangeMap['M'] = monthRange;
      _valueRangeMap['d'] = dayRange;
    });

    if (monthRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      var currMonth = _currMonth!;
      _monthScrollCtrl!.jumpToItem(monthRange.last - monthRange.first);
      if (currMonth < monthRange.last) {
        _monthScrollCtrl!.jumpToItem(currMonth - monthRange.first);
      }
    }

    if (dayRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      var currDay = _currDay!;

      if (currDay < dayRange.last) {
        _dayScrollCtrl!.jumpToItem(currDay - dayRange.first);
      } else {
        _dayScrollCtrl!.jumpToItem(dayRange.last - dayRange.first);
      }
    }

    _isChangeDateRange = false;
  }

  /// calculate the count of day in current month
  int _calcDayCountOfMonth() {
    if (_currMonth == 2) {
      return isLeapYear(_currYear!) ? 29 : 28;
    } else if (_solarMonthsOf31Days.contains(_currMonth)) {
      return 31;
    }
    return 30;
  }

  /// whether or not is leap year
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// calculate selected index list
  List<int> _calcSelectIndexList() {
    var yearIndex = _currYear! - _minDateTime.year;
    var monthIndex = _currMonth! - _monthRange!.first;
    var dayIndex = _currDay! - _dayRange!.first;
    return [yearIndex, monthIndex, dayIndex];
  }

  /// calculate the range of year
  List<int> _calcYearRange() {
    return [_minDateTime.year, _maxDateTime.year];
  }

  /// calculate the range of month
  List<int> _calcMonthRange() {
    var minMonth = 1, maxMonth = 12;
    var minYear = _minDateTime.year;
    var maxYear = _maxDateTime.year;
    if (minYear == _currYear) {
      // selected minimum year, limit month range
      minMonth = _minDateTime.month;
    }
    if (maxYear == _currYear) {
      // selected maximum year, limit month range
      maxMonth = _maxDateTime.month;
    }
    return [minMonth, maxMonth];
  }

  /// calculate the range of day
  List<int> _calcDayRange({currMonth}) {
    var minDay = 1, maxDay = _calcDayCountOfMonth();
    var minYear = _minDateTime.year;
    var maxYear = _maxDateTime.year;
    var minMonth = _minDateTime.month;
    var maxMonth = _maxDateTime.month;
    currMonth ??= _currMonth;
    if (minYear == _currYear && minMonth == currMonth) {
      // selected minimum year and month, limit day range
      minDay = _minDateTime.day;
    }
    if (maxYear == _currYear && maxMonth == currMonth) {
      // selected maximum year and month, limit day range
      maxDay = _maxDateTime.day;
    }
    return [minDay, maxDay];
  }
}
