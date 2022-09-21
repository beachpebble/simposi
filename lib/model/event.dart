import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/interest.dart';

import 'gender.dart';
import 'generation.dart';
import 'image.dart';

part 'event.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Event extends Equatable {
  @JsonKey(name: 'id', required: true, disallowNullValue: true)
  final int id;
  @JsonKey(name: 'title', required: true, disallowNullValue: true)
  final String title;
  @JsonKey(
      name: 'datetime',
      required: true,
      disallowNullValue: true,
      fromJson: _dateFromJson)
  final DateTime datetime;

  @JsonKey(name: 'description', required: true, disallowNullValue: true)
  final String description;
  @JsonKey(name: 'status', required: true, disallowNullValue: true)
  final String status;
  @JsonKey(name: 'user_id', required: true, disallowNullValue: true)
  final int userId;
  @JsonKey(name: 'image', required: true, disallowNullValue: true)
  final Image image;
  @JsonKey(name: 'rsvp_accepted', required: true, disallowNullValue: true)
  final int rsvpAccepted;
  @JsonKey(name: 'rsvp_declined', required: true, disallowNullValue: true)
  final int rsvpDeclined;

  @JsonKey(name: 'latitude', required: true, disallowNullValue: true)
  final String latitude;
  @JsonKey(name: 'longitude', required: true, disallowNullValue: true)
  final String longitude;
  @JsonKey(name: 'location_name', required: true, disallowNullValue: true)
  final String locationName;
  @JsonKey(name: 'location_address', required: true, disallowNullValue: true)
  final String locationAddress;
  @JsonKey(name: 'location_city', required: true, disallowNullValue: true)
  final String locationCity;
  @JsonKey(name: 'is_lgbtq', required: true, disallowNullValue: true)
  final bool isLgbt;
  @JsonKey(name: 'want_to_meets', required: true, disallowNullValue: true)
  final List<Gender> wantToMeetGenders;
  @JsonKey(name: 'generations', required: false, disallowNullValue: true)
  final List<Generation> wantToMeetGenerations;
  @JsonKey(name: 'who_earns', required: true, disallowNullValue: true)
  final List<Earning> wantToMeetEarnings;
  @JsonKey(name: 'what_you_likes', required: true, disallowNullValue: true)
  final List<Interest> wantToMeetInterests;

  const Event({
    required this.id,
    required this.title,
    required this.datetime,
    required this.description,
    required this.status,
    required this.userId,
    required this.image,
    required this.rsvpAccepted,
    required this.rsvpDeclined,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.locationAddress,
    required this.locationCity,
    required this.isLgbt,
    required this.wantToMeetGenders,
    required this.wantToMeetGenerations,
    required this.wantToMeetEarnings,
    required this.wantToMeetInterests,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        datetime,
        description,
        status,
        userId,
        image,
        rsvpAccepted,
        rsvpDeclined,
        latitude,
        longitude,
        locationName,
        locationAddress,
        locationCity,
        isLgbt,
        wantToMeetGenders,
        wantToMeetGenerations,
        wantToMeetEarnings,
        wantToMeetInterests,
      ];

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

DateTime _dateFromJson(String json) => DateTime.parse("${json}Z");
