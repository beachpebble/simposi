import 'package:simposi_app_v4/model/event.dart';

import 'api_service.dart';

class CalendarRepository {
  final ApiService _apiService;

  CalendarRepository(this._apiService);

  List<CalEvent> getAllevents()  {
    //await Future.delayed(Duration(seconds: 2));
    return [
      CalEvent(id:0, title: "New super event", date: DateTime.now()),
      CalEvent(id:1, title: "New super event2", date: DateTime.now().subtract(Duration(days: 1))),
      CalEvent(id:2, title: "New super event3", date: DateTime.now().add(Duration(days: 1))),
      CalEvent(id:3, title: "New super event4", date: DateTime.now().add(Duration(days: 2))),
      CalEvent(id:6, title: "New super event5", date: DateTime.now().add(Duration(days: 5))),
      CalEvent(id:7, title: "New super event6", date: DateTime.now().add(Duration(days: 8))),
    ];
  }
}