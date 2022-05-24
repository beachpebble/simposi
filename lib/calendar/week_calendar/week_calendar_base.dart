import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'utils.dart';
import 'week_calendar_core.dart';

class WeekCalendarBase extends StatefulWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DayBuilder dowBuilder;
  final FocusedDayBuilder dayBuilder;
  final double dowHeight;
  final double rowHeight;
  final Duration formatAnimationDuration;
  final Curve formatAnimationCurve;
  final bool pageAnimationEnabled;
  final Duration pageAnimationDuration;
  final Curve pageAnimationCurve;
  final SimpleSwipeConfig simpleSwipeConfig;
  final SwipeCallback? onVerticalSwipe;
  final void Function(DateTime focusedDay)? onPageChanged;
  final void Function(CalendarController calendarController, )? onCalendarCreated;

  const WeekCalendarBase({
    Key? key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.dowBuilder,
    required this.dayBuilder,
    required this.dowHeight,
    required this.rowHeight,
    this.formatAnimationDuration = const Duration(milliseconds: 200),
    this.formatAnimationCurve = Curves.linear,
    this.pageAnimationEnabled = true,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.easeOut,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.onVerticalSwipe,
    this.onPageChanged,
    this.onCalendarCreated,
  }) : super(key: key);

  @override
  _WeekCalendarBaseState createState() => _WeekCalendarBaseState();
}

class _WeekCalendarBaseState extends State<WeekCalendarBase>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final CalendarController _calendarController;
  late DateTime _focusedDay;
  late int _previousIndex;
  late bool _pageCallbackDisabled;
  late int _pageCallbackDisabledSteps;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
    final initialPage = _calculateFocusedPage(widget.firstDay, _focusedDay);
    _pageController = PageController(initialPage: initialPage);
    _calendarController = CalendarController(_pageController, (steps){
      _pageCallbackDisabled = true;
      _pageCallbackDisabledSteps = steps;
    });
    widget.onCalendarCreated?.call(_calendarController);
    _previousIndex = initialPage;
    _pageCallbackDisabled = false;
    _pageCallbackDisabledSteps = 0;
  }

  @override
  void didUpdateWidget(WeekCalendarBase oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_focusedDay != widget.focusedDay) {
      _focusedDay = widget.focusedDay;
      _updatePage();
    }
  }

  bool get _canScrollHorizontally => true;

  void _updatePage() {
    print("!!!!!!!  WTFFFFFF");
    final currentIndex = _calculateFocusedPage(widget.firstDay, _focusedDay);

    final endIndex = _calculateFocusedPage(widget.firstDay, widget.lastDay);

    if (currentIndex != _previousIndex ||
        currentIndex == 0 ||
        currentIndex == endIndex) {
      _pageCallbackDisabled = true;
    }

    if (widget.pageAnimationEnabled) {
      if ((currentIndex - _previousIndex).abs() > 1) {
        final jumpIndex =
            currentIndex > _previousIndex ? currentIndex - 1 : currentIndex + 1;

        _pageController.jumpToPage(jumpIndex);
      }

      _pageController.animateToPage(
        currentIndex,
        duration: widget.pageAnimationDuration,
        curve: widget.pageAnimationCurve,
      );
    } else {
      _pageController.jumpToPage(currentIndex);
    }
    _previousIndex = currentIndex;
    _pageCallbackDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: WeekCalendarCore(
        pageController: _pageController,
        scrollPhysics: _canScrollHorizontally
            ? const PageScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        firstDay: widget.firstDay,
        lastDay: widget.lastDay,
        previousIndex: _previousIndex,
        focusedDay: _focusedDay,
        dowHeight: widget.dowHeight,
        rowHeight: widget.rowHeight,
        onPageChanged: (index, focused) {
          print("! IS DISABLED  $_pageCallbackDisabled  $_pageCallbackDisabledSteps");
          if (!_pageCallbackDisabled && _pageCallbackDisabledSteps == 0) {
            if (!isSameDay(_focusedDay, focused)) {
              _focusedDay = focused;
            }
            _previousIndex = index;
            widget.onPageChanged?.call(focused);
          }
          _pageCallbackDisabled = false;
          if (_pageCallbackDisabledSteps > 0) {
            _pageCallbackDisabledSteps--;
          }
        },
        dowBuilder: widget.dowBuilder,
        dayBuilder: widget.dayBuilder,
      ),
    );
  }

  int _calculateFocusedPage(DateTime startDay, DateTime focusedDay) {
    return focusedDay.difference(_firstDayOfWeek(startDay)).inDays ~/ 7;
  }

  int _getDaysBefore(DateTime firstDay) {
    return (firstDay.weekday) % 7;
  }

  DateTime _firstDayOfWeek(DateTime week) {
    final daysBefore = _getDaysBefore(week);
    return week.subtract(Duration(days: daysBefore));
  }
}
