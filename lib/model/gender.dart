import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GenderType {
  MALE, FEMALE, LGBTQ, EVERYONE
}

class Gender implements Equatable{
  final GenderType gender;
  final String id;

  Gender(this.gender, this.id);

  static Gender Male = Gender(GenderType.MALE, "1");
  static Gender Female = Gender(GenderType.FEMALE, "2");
  static Gender Lgbt =  Gender(GenderType.LGBTQ, "3");
  static Gender EveryOne =  Gender(GenderType.EVERYONE, "4");

  static Gender? fromId(String id) {
    switch (id) {
      case "1": return Male;
      case "2": return Female;
      case "3": return Lgbt;
      case "4": return EveryOne;
      default: null;
    }
  }

  @override
  List<Object?> get props => [gender, id];

  @override
  bool? get stringify => true;
}