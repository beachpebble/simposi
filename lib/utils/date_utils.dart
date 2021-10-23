class SimposiDateUtils {

  SimposiDateUtils._();

  static DateTime weekStart(DateTime date) {
    int daysOfWeek = date.weekday == 7 ? 0: date.weekday;
    DateTime eventWeekStart = date
        .subtract(Duration(days: daysOfWeek));
    return eventWeekStart;
  }


}
