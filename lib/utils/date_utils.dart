class SimposiDateUtils {

  SimposiDateUtils._();

  static DateTime weekStart(DateTime date) {
    final daysOfWeek = date.weekday == 7 ? 0: date.weekday;
    final eventWeekStart = date
        .subtract(Duration(days: daysOfWeek));
    return eventWeekStart;
  }


}
