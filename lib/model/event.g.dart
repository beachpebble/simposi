// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'title',
      'datetime',
      'description',
      'status',
      'user_id',
      'image',
      'rsvp_accepted',
      'rsvp_declined',
      'latitude',
      'longitude',
      'location_name',
      'location_address',
      'location_city',
      'is_lgbtq',
      'want_to_meets',
      'who_earns',
      'what_you_likes'
    ],
    disallowNullValues: const [
      'id',
      'title',
      'datetime',
      'description',
      'status',
      'user_id',
      'image',
      'rsvp_accepted',
      'rsvp_declined',
      'latitude',
      'longitude',
      'location_name',
      'location_address',
      'location_city',
      'is_lgbtq',
      'want_to_meets',
      'generations',
      'who_earns',
      'what_you_likes'
    ],
  );
  return Event(
    id: json['id'] as int,
    title: json['title'] as String,
    datetime: _dateFromJson(json['datetime'] as String),
    description: json['description'] as String,
    status: json['status'] as String,
    userId: json['user_id'] as int,
    image: Image.fromJson(json['image'] as Map<String, dynamic>),
    rsvpAccepted: json['rsvp_accepted'] as int,
    rsvpDeclined: json['rsvp_declined'] as int,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    locationName: json['location_name'] as String,
    locationAddress: json['location_address'] as String,
    locationCity: json['location_city'] as String,
    isLgbt: json['is_lgbtq'] as bool,
    wantToMeetGenders: (json['want_to_meets'] as List<dynamic>)
        .map((e) => Gender.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetGenerations: (json['generations'] as List<dynamic>)
        .map((e) => Generation.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetEarnings: (json['who_earns'] as List<dynamic>)
        .map((e) => Earning.fromJson(e as Map<String, dynamic>))
        .toList(),
    wantToMeetInterests: (json['what_you_likes'] as List<dynamic>)
        .map((e) => Interest.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'datetime': instance.datetime.toIso8601String(),
      'description': instance.description,
      'status': instance.status,
      'user_id': instance.userId,
      'image': instance.image,
      'rsvp_accepted': instance.rsvpAccepted,
      'rsvp_declined': instance.rsvpDeclined,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location_name': instance.locationName,
      'location_address': instance.locationAddress,
      'location_city': instance.locationCity,
      'is_lgbtq': instance.isLgbt,
      'want_to_meets': instance.wantToMeetGenders,
      'generations': instance.wantToMeetGenerations,
      'who_earns': instance.wantToMeetEarnings,
      'what_you_likes': instance.wantToMeetInterests,
    };
