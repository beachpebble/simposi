import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';

part 'user_meta.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UserMeta extends Equatable {
  @JsonKey(name: 'wtm_genders', required: true, disallowNullValue: false)
  final List<Gender> wantToMeetGender;
  @JsonKey(name: 'wtm_generations', required: true, disallowNullValue: false)
  final List<Generation> wantToMeetGenerations;
  @JsonKey(name: 'wtm_earnings', required: true, disallowNullValue: false)
  final List<Earning> wantToMeetEarnings;
  @JsonKey(name: 'wtm_interests', required: true, disallowNullValue: false)
  final List<Interest> wantToMeetInterests;
  @JsonKey(name: 'wtm_lgbt', required: true, disallowNullValue: false)
  final bool wantToMeetLgbt;

  UserMeta(
      {required this.wantToMeetGender,
      required this.wantToMeetGenerations,
      required this.wantToMeetEarnings,
      required this.wantToMeetLgbt,
      required this.wantToMeetInterests});

  @override
  List<Object?> get props => [wantToMeetGender, wantToMeetGenerations, wantToMeetEarnings, wantToMeetLgbt, wantToMeetInterests];

  factory UserMeta.fromJson(Map<String, dynamic> json) => _$UserMetaFromJson(json);

  Map<String, dynamic> toJson() => _$UserMetaToJson(this);

  UserMeta copy({List<Gender>? wantToMeetGender, List<Generation>? wantToMeetGenerations, List<Earning>? wantToMeetEarnings, List<Interest>? wantToMeetInterests, bool? lgbt}) {
    return UserMeta(
        wantToMeetGender: wantToMeetGender?? this.wantToMeetGender,
      wantToMeetGenerations: wantToMeetGenerations?? this.wantToMeetGenerations,
      wantToMeetEarnings: wantToMeetEarnings?? this.wantToMeetEarnings,
      wantToMeetInterests: wantToMeetInterests?? this.wantToMeetInterests,
      wantToMeetLgbt: lgbt?? this.wantToMeetLgbt
    );
  }
}
