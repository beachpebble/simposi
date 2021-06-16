import 'package:equatable/equatable.dart';

import 'interest.dart';

class MasterData implements Equatable {
  final List<Interest> interests;

  MasterData(this.interests);

  @override
  List<Object?> get props => [interests];

  @override
  bool? get stringify => true;
}
