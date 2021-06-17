import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [gender, id];

  @override
  bool? get stringify => true;
}