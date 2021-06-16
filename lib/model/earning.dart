import 'package:equatable/equatable.dart';

enum EarningType {
  LESS_35, FROM75TO100, FROM35TO50, FROM100TO150, FROM50TO75, MORE150
}

class Earning implements Equatable{
  final EarningType earning;
  final int id;

  Earning(this.earning, this.id);

  static Earning less35 = Earning(EarningType.LESS_35, 1);
  static Earning from75to100 = Earning(EarningType.FROM75TO100, 1);
  static Earning from35to50 = Earning(EarningType.FROM35TO50, 1);
  static Earning from100to150 = Earning(EarningType.FROM100TO150, 1);
  static Earning from50to75 = Earning(EarningType.FROM50TO75, 1);
  static Earning more150 = Earning(EarningType.MORE150, 1);


  @override
  List<Object?> get props => [earning, id];

  @override
  bool? get stringify => true;
}