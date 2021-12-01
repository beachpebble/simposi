import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'profile_status.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ProfileStatus extends Equatable {

  @JsonKey(name: 'checked_in_event_id', required: true)
  final int? eventId;
  @JsonKey(name: 'checked_in_event_date', required: true)
  final DateTime? eventDate;
  @JsonKey(name: 'required_survey_by_users', required: true)
  final bool surveyNeed;

  bool get isOnEvent => eventId != null && eventId! > 0;

  ProfileStatus({this.eventId, this.eventDate, required this.surveyNeed});

  factory ProfileStatus.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatusToJson(this);

  @override
  List<Object?> get props => [eventId, eventDate, surveyNeed];
}