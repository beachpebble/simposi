import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interest.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Interest extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'title', required: true, disallowNullValue: true)
  final String title;

  const Interest({required this.id, required this.title});


  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;

  factory Interest.fromJson(Map<String, dynamic> json) => _$InterestFromJson(json);

  Map<String, dynamic> toJson() => _$InterestToJson(this);
}
