import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_required.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class SurveyRequired extends Equatable {

  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'userName', required: true, disallowNullValue: true)
  final String userName;
  @JsonKey(name: 'userPhoto', required: true, disallowNullValue: true)
  final String userPhoto;
  @JsonKey(name: 'eventId', required: true, disallowNullValue: true)
  final int eventId;
  @JsonKey(name: 'eventName', required: true, disallowNullValue: true)
  final String eventName;
  @JsonKey(name: 'eventDate', required: true, disallowNullValue: true)
  final DateTime eventDate;

  SurveyRequired(this.id, this.userName, this.userPhoto, this.eventId, this.eventName, this.eventDate);

  @override
  List<Object?> get props => [id, userName, userPhoto, eventId, eventName, eventDate];

  factory SurveyRequired.fromJson(Map<String, dynamic> json) => _$SurveyRequiredFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyRequiredToJson(this);
}