import 'package:equatable/equatable.dart';

class CalEvent extends Equatable {
  final int id;
  final String title;
  final DateTime date;

  CalEvent({required this.id, required this.title, required this.date});

  @override
  List<Object> get props => [id, title, date];

  @override
  bool get stringify => true;
}
