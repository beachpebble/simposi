import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Survey extends Equatable {

  @JsonKey(name: 'user_id', required: true, disallowNullValue: true)
  final int userId;

  @JsonKey(name: 'event_id', required: true, disallowNullValue: true)
  final int eventId;

  @JsonKey(name: 'rate', required: true, disallowNullValue: true)
  final int rate;

  @JsonKey(name: 'text', required: true, disallowNullValue: true)
  final String? reportText;

  Survey({required this.userId, required this.eventId, required this.rate, this.reportText});

  @override
  List<Object?> get props => [userId, eventId, rate, reportText];

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}
