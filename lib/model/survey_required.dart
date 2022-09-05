import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_required.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class SurveyRequired extends Equatable {

  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'user_id', required: true, disallowNullValue: true)
  final int userId;
  @JsonKey(name: 'user_name', required: true, disallowNullValue: true)
  final String userName;
  @JsonKey(name: 'user_photo', required: true, disallowNullValue: true)
  final String userPhoto;
  @JsonKey(name: 'event_id', required: true, disallowNullValue: true)
  final int eventId;
  @JsonKey(name: 'event_name', required: true, disallowNullValue: true)
  final String eventName;
  @JsonKey(name: 'event_date', required: true, disallowNullValue: true)
  final DateTime eventDate;

  const SurveyRequired(
      {required this.id,
      required this.userName,
      required this.userPhoto,
      required this.eventId,
      required this.eventName,
      required this.eventDate,
      required this.userId});

  @override
  List<Object?> get props => [id, userName, userPhoto, eventId, eventName, eventDate, userId];

  factory SurveyRequired.fromJson(Map<String, dynamic> json) => _$SurveyRequiredFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyRequiredToJson(this);
}