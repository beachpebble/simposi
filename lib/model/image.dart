import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Image extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'name', required: true, disallowNullValue: true)
  final String name;
  @JsonKey(name: 'url', required: true, disallowNullValue: true)
  final String url;

  Image({
    required this.id,
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
