import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GenderType {
  MALE, FEMALE
}

class Gender extends Equatable{
  final GenderType gender;
  final String id;

  Gender(this.gender, this.id);

  static Gender Male = Gender(GenderType.MALE, "1");
  static Gender Female = Gender(GenderType.FEMALE, "2");

  static Gender? fromId(String id) {
    switch (id) {
      case "1": return Male;
      case "2": return Female;
      default: null;
    }
  }

  @override
  List<Object?> get props => [gender, id];

  @override
  bool? get stringify => true;
}