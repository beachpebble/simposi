import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'profile_status.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ProfileStatus extends Equatable {

  @JsonKey(name: 'checked_in_event_id', required: true)
  final int? eventId;
  @JsonKey(name: 'checked_in_event_date', required: true)
  final DateTime? eventDate;
  @JsonKey(name: 'required_survey_by_events', required: true)
  final List<int>? surveyIds;

  bool get isOnEvent => eventId != null && eventId! > 0;

  ProfileStatus({required this.eventId, required this.eventDate, required this.surveyIds});

  factory ProfileStatus.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatusToJson(this);

  @override
  List<Object?> get props => [eventId, eventDate, surveyIds];
}