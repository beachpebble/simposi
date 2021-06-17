import 'package:equatable/equatable.dart';

import 'errors.dart';

class Earning implements Equatable {
  final int id;
  final String title;

  Earning({required this.id, required this.title});

  static Earning fromJson(Map json) {
    int? parsedId =
        json.containsKey('who_earns_id') ? json['who_earns_id'] : null;
    String? parsedTitle = json.containsKey('title') ? json['title'] : null;

    if (parsedId == null || parsedTitle == null)
      throw ParseException(message: "Incorrect data structure");

    return Earning(id: parsedId, title: parsedTitle);
  }

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
