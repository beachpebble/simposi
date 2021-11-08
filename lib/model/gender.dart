import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GenderType {
  MALE, FEMALE
}

class Gender extends Equatable{
  final GenderType gender;
  final int id;

  Gender(this.gender, this.id);

  static Gender Male = Gender(GenderType.MALE, 1);
  static Gender Female = Gender(GenderType.FEMALE, 2);

  factory Gender.fromJson(Map<String, dynamic> json){
    return json['id'] == 1 ?  Gender.Male  :  Gender.Female;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id
    };
  }

  @override
  List<Object?> get props => [gender, id];

  @override
  bool? get stringify => true;
}