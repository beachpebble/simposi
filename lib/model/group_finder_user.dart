import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_finder_user.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class GroupFinderUser extends Equatable {

  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'name', required: true, disallowNullValue: true)
  final String name;
  @JsonKey(name: 'photo', required: true, disallowNullValue: true)
  final String imageUrl;
  @JsonKey(name: 'longitude', required: true, disallowNullValue: true)
  final String longitude;
  @JsonKey(name: 'latitude', required: true, disallowNullValue: true)
  final String latitude;

  GroupFinderUser( {required this.id, required this.name, required this.imageUrl, required this.longitude, required this.latitude});

  @override
  List<Object?> get props => [id, name, imageUrl, longitude, latitude];

  @override
  bool get stringify => true;

  factory GroupFinderUser.fromJson(Map<String, dynamic> json) =>
      _$GroupFinderUserFromJson(json);

  Map<String, dynamic> toJson() => _$GroupFinderUserToJson(this);

}