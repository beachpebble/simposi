import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generation.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Generation extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'title', required: true, disallowNullValue: true)
  final String title;

  Generation({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;

  factory Generation.fromJson(Map<String, dynamic> json) =>
      _$GenerationFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationToJson(this);
}
