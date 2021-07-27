import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';

import 'generation.dart';
import 'interest.dart';

class MasterData implements Equatable {
  final Set<Interest> interests;
  final List<Generation> generations;
  final List<Earning> earnings;

  MasterData(this.interests, this.generations, this.earnings);

  @override
  List<Object?> get props => [interests, generations, earnings];

  @override
  bool? get stringify => true;
}
