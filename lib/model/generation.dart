import 'package:equatable/equatable.dart';

import 'errors.dart';

class Generation extends Equatable {
  final int id;
  final String title;

  Generation({required this.id, required this.title});

  static Generation fromJson(Map json) {
    int? parsedId = json.containsKey('generations_identify_id')
        ? json['generations_identify_id']
        : null;
    String? parsedTitle = json.containsKey('title') ? json['title'] : null;

    if (parsedId == null || parsedTitle == null)
      throw ParseException(message: "Incorrect data structure");

    return Generation(id: parsedId, title: parsedTitle);
  }

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
