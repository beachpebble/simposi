import 'package:flutter/material.dart';

typedef DayBuilder = Widget? Function(BuildContext context, DateTime day);

typedef FocusedDayBuilder = Widget Function(
    BuildContext context, DateTime day, DateTime focusedDay);

typedef EventChecker = bool Function(
    DateTime day);

DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

class CalendarController {
  final PageController pageController;
  final Function(int) withOutCallback;
  CalendarController(this.pageController, this.withOutCallback);

  Future<void> animateToPage(int page, { bool callback = true}) {
    int currentPage = pageController.page?.round() ?? 0;
    int dif = (page - currentPage).abs();
    print("Cal controleer ----   $page    $currentPage");
    if (!callback) {
      withOutCallback.call(dif);
    }
    return pageController.animateToPage(page,  duration: Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
  int getPage() {
    return pageController.page?.round() ?? 0;
  }

}

