import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'errors.dart';

part 'earning.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Earning extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'title', required: true, disallowNullValue: true)
  final String title;
  @JsonKey(name: 'sort', required: true, disallowNullValue: true)
  final int sortId;

  Earning({required this.id, required this.title, required this.sortId});

  factory Earning.fromJson(Map<String, dynamic> json) => _$EarningFromJson(json);

  Map<String, dynamic> toJson() => _$EarningToJson(this);

  @override
  List<Object> get props => [id, title, sortId];

  @override
  bool get stringify => true;
}
