import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

import 'utils.dart';

typedef _OnCalendarPageChanged = void Function(
    int pageIndex, DateTime focusedDay);

class WeekCalendarCore extends StatelessWidget {
  final DayBuilder dowBuilder;
  final FocusedDayBuilder dayBuilder;
  final DateTime? focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final bool sixWeekMonthsEnforced;
  final bool dowVisible;
  final Decoration? dowDecoration;
  final Decoration? rowDecoration;
  final double? dowHeight;
  final double? rowHeight;
  final int? previousIndex;
  final PageController? pageController;
  final ScrollPhysics? scrollPhysics;
  final _OnCalendarPageChanged onPageChanged;

  const WeekCalendarCore({
    Key? key,
    required this.onPageChanged,
    required this.firstDay,
    required this.lastDay,
    required this.dayBuilder,
    required this.dowBuilder,
    this.dowHeight,
    this.rowHeight,
    this.pageController,
    this.focusedDay,
    this.previousIndex,
    this.sixWeekMonthsEnforced = false,
    this.dowVisible = true,
    this.dowDecoration,
    this.rowDecoration,
    this.scrollPhysics,
  })  : assert(!dowVisible || (dowHeight != null && dowBuilder != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: scrollPhysics,
      itemCount: _getPageCount(firstDay, lastDay),
      itemBuilder: (context, index) {
        final baseDay = _getBaseDay(index);
        final visibleRange = _getVisibleRange(baseDay);
        final visibleDays = _daysInRange(visibleRange.start, visibleRange.end);
        return _calendarPage(
          context: context,
          visibleDays: visibleDays,
          dowDecoration: dowDecoration,
          rowDecoration: rowDecoration,
          dowBuilder: (context, day) {
            return SizedBox(
              height: dowHeight,
              child: dowBuilder.call(context, day),
            );
          },
          dayBuilder: (context, day) {
            DateTime baseDay;
            baseDay = _getBaseDay(index);

            return SizedBox(
              height: rowHeight,
              child: dayBuilder(context, day, baseDay),
            );
          },
        );
      },
      onPageChanged: (index) {
        DateTime baseDay;
        baseDay = _getBaseDay(index);

        print("PageView ON PG CHANGED    $index");
        return onPageChanged(index, baseDay);
      },
    );
  }

  Widget _calendarPage({
    required BuildContext context,
    required Widget Function(BuildContext context, DateTime day)? dowBuilder,
    required Widget Function(BuildContext context, DateTime day) dayBuilder,
    required List<DateTime> visibleDays,
    required Decoration? dowDecoration,
    required Decoration? rowDecoration,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        7,
        (index) {
          bool today = DateUtils.isSameDay(DateTime.now(), visibleDays[index]);
          return Container(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            decoration: today
                ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: SimposiAppColors.simposiFadedBlue,
                    shape: BoxShape.rectangle,
                  )
                : null,
            child: Column(
              children: [
                dowBuilder!(context, visibleDays[index]),
                dayBuilder(context, visibleDays[index]),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  int _getPageCount(DateTime first, DateTime last) {
    return last.difference(_firstDayOfWeek(first)).inDays ~/ 7;
  }

  DateTime _getBaseDay(int pageIndex) {
    DateTime day;
    day = DateTime.utc(
        firstDay.year, firstDay.month, firstDay.day + pageIndex * 7);

    if (day.isBefore(firstDay)) {
      day = firstDay;
    } else if (day.isAfter(lastDay)) {
      day = lastDay;
    }
    return day;
  }

  DateTimeRange _getVisibleRange(DateTime focusedDay) {
    final daysBefore = _getDaysBefore(focusedDay);
    final firstToDisplay = focusedDay.subtract(Duration(days: daysBefore));
    final lastToDisplay = firstToDisplay.add(const Duration(days: 7));
    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  DateTime _firstDayOfWeek(DateTime week) {
    final daysBefore = _getDaysBefore(week);
    return week.subtract(Duration(days: daysBefore));
  }

  int _getDaysBefore(DateTime firstDay) {
    return firstDay.weekday % 7;
  }
}
