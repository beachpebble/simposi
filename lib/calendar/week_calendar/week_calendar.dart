import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils.dart';
import 'week_calendar_base.dart';

class WeekCalendar extends StatefulWidget {
  final dynamic locale;
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? currentDay;
  final bool headerVisible;
  final bool daysOfWeekVisible;
  final bool shouldFillViewport;
  final double rowHeight;
  final double daysOfWeekHeight;
  final Duration pageAnimationDuration;
  final Curve pageAnimationCurve;
  final List<int> weekendDays;
  final void Function(DateTime focusedDay)? onPageChanged;
  final void Function(CalendarController calendarController)? onCalendarCreated;
  final FocusedDayBuilder todayBuilder;
  final FocusedDayBuilder defaultBuilder;
  final EventChecker eventChecker;

  WeekCalendar({
    Key? key,
    this.locale,
    required DateTime focusedDay,
    required DateTime firstDay,
    required DateTime lastDay,
    DateTime? currentDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.headerVisible = true,
    this.daysOfWeekVisible = true,
    this.shouldFillViewport = false,
    this.rowHeight = 52.0,
    this.daysOfWeekHeight = 16.0,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.easeOut,
    this.onPageChanged,
    this.onCalendarCreated,
    required this.todayBuilder,
    required this.defaultBuilder,
    required this.eventChecker,
  })  : focusedDay = normalizeDate(focusedDay),
        firstDay = normalizeDate(firstDay),
        lastDay = normalizeDate(lastDay),
        currentDay = currentDay ?? DateTime.now(),
        super(key: key);

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  // late final PageController _pageController;
  late final ValueNotifier<DateTime> _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(widget.focusedDay);
  }

  @override
  void didUpdateWidget(WeekCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_focusedDay.value != widget.focusedDay) {
      _focusedDay.value = widget.focusedDay;
    }
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.headerVisible)
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return Container();
            },
          ),
        WeekCalendarBase(
          onCalendarCreated: (pageController) {
            //_pageController = pageController;
            widget.onCalendarCreated?.call(pageController);
          },
          focusedDay: _focusedDay.value,
          firstDay: widget.firstDay,
          lastDay: widget.lastDay,
          dowHeight: widget.daysOfWeekHeight,
          rowHeight: widget.rowHeight,
          pageAnimationDuration: widget.pageAnimationDuration,
          pageAnimationCurve: widget.pageAnimationCurve,
          onPageChanged: (focusedDay) {
            _focusedDay.value = focusedDay;
            widget.onPageChanged?.call(focusedDay);
          },
          dowBuilder: (BuildContext context, DateTime day) {
            final weekdayString = DateFormat.E(widget.locale).format(day);
            final Widget dowCell = Center(
              child: Text(
                weekdayString,
              ),
            );
            return dowCell;
          },
          dayBuilder: (context, day, focusedMonth) {
            return _buildCell(day, focusedMonth);
          },
        )
      ],
    );
  }

  Widget _buildCell(DateTime day, DateTime focusedDay) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shorterSide = constraints.maxHeight > constraints.maxWidth
            ? constraints.maxWidth
            : constraints.maxHeight;
        final children = <Widget>[];
        final isToday = isSameDay(day, widget.currentDay);

        final content = (isToday)
            ? widget.todayBuilder.call(context, day, focusedDay)
            : widget.defaultBuilder.call(context, day, focusedDay);

        children.add(content);
        final hasEvents = widget.eventChecker.call(day);
        if (hasEvents) {
          final center = constraints.maxHeight / 2;
          const markerSize = 4.0;
          final markerAutoAlignmentTop = center +
              (shorterSide - const EdgeInsets.all(6.0).vertical) / 2 -
              (markerSize * 0.7);
          children.add(PositionedDirectional(
            top: markerAutoAlignmentTop,
            bottom: null,
            start: null,
            end: null,
            child: _buildSingleMarker(markerSize),
          ));
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.hardEdge,
          children: children,
        );
      },
    );
  }

  Widget _buildSingleMarker(double markerSize) {
    return Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ));
  }
}
