import 'package:equatable/equatable.dart';

enum GenerationType {
  IGEN, MILLENIAL, GENX, BOOMER, SILENT
}

class Generation implements Equatable{
  final GenerationType generation;
  final int id;

  Generation(this.generation, this.id);

  static Generation IGen = Generation(GenerationType.IGEN, 2);
  static Generation Millenial = Generation(GenerationType.MILLENIAL, 3);
  static Generation GenX =  Generation(GenerationType.GENX, 4);
  static Generation Boomer =  Generation(GenerationType.BOOMER, 5);
  static Generation Silent =  Generation(GenerationType.SILENT, 6);

  @override
  List<Object?> get props => [generation, id];

  @override
  bool? get stringify => true;
}