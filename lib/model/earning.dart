import 'package:equatable/equatable.dart';

import 'errors.dart';

class Earning extends Equatable {
  final int id;
  final String title;
  final int sortId;

  Earning({required this.id, required this.title, required this.sortId});

  static Earning fromJson(Map json) {
    int? parsedId =
        json.containsKey('id') ? json['id'] : null;
    int? parsedSortId = json.containsKey('sort') ? json['sort'] : null;
    String? parsedTitle = json.containsKey('title') ? json['title'] : null;

    if (parsedId == null || parsedTitle == null || parsedSortId == null)
      throw ParseException(message: "Incorrect data structure");

    return Earning(id: parsedId, title: parsedTitle, sortId: parsedSortId);
  }

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
