import 'package:equatable/equatable.dart';

class EmergencyContact extends Equatable {
  final String name;
  final String phone;

  const EmergencyContact(this.name, this.phone);

  @override
  List<Object?> get props => [name, phone];
}
