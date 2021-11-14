import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rsvp_status.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class RsvpStatus extends Equatable {

  static const String INVITED = "Invited";
  static const String OPENED = "Opened";
  static const String ACCEPTED = "Accepted";
  static const String CANCELED = "Cancelled";
  static const String DECLINED = "Declined";

  static const int INVITED_ID = 1;
  static const int OPENED_ID = 2;
  static const int ACCEPTED_ID = 3;
  static const int CANCELED_ID = 7;
  static const int DECLINED_ID = 8;

  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'title', required: true, disallowNullValue: true)
  final String title;

  RsvpStatus(this.id, this.title);

  @override
  List<Object?> get props => [id, title];

  factory RsvpStatus.fromJson(Map<String, dynamic> json) => _$RsvpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RsvpStatusToJson(this);
}
