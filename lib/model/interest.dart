import 'package:equatable/equatable.dart';

import 'errors.dart';

class Interest extends Equatable {
  final int id;
  final String title;

  Interest({required this.id, required this.title});

  static Interest fromJson(Map json) {
    int? parsedId = json.containsKey('id') ? json['id'] : null;
    String? parsedTitle = json.containsKey('title') ? json['title'] : null;

    if (parsedId == null || parsedTitle == null)
      throw ParseException(message: "Incorrect data structure");

    return Interest(
        id: parsedId, title: parsedTitle);
  }

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
