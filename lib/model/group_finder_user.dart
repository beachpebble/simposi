import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_finder_user.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class GroupFinderUser extends Equatable {

  @JsonKey(name: 'name', required: true, disallowNullValue: true)
  final String name;
  @JsonKey(name: 'imageUrl', required: true, disallowNullValue: true)
  final String imageUrl;
  @JsonKey(name: 'longitude', required: true, disallowNullValue: true)
  final double longitude;
  @JsonKey(name: 'latitude', required: true, disallowNullValue: true)
  final double latitude;

  GroupFinderUser({required this.name, required this.imageUrl, required this.longitude, required this.latitude});

  @override
  List<Object?> get props => [name, imageUrl, longitude, latitude];

  @override
  bool get stringify => true;

  factory GroupFinderUser.fromJson(Map<String, dynamic> json) =>
      _$GroupFinderUserFromJson(json);

  Map<String, dynamic> toJson() => _$GroupFinderUserToJson(this);

}