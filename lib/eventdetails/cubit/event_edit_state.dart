part of 'event_edit_cubit.dart';

abstract class EventEditState extends Equatable {
  const EventEditState();

  @override
  List<Object> get props => [];
}

class EventEditInitial extends EventEditState {
}

class EventEditLoading extends EventEditState {}

class EventEditError extends EventEditState {
  final dynamic error;

  EventEditError(this.error);

  @override
  List<Object> get props => [error];
}

class EventEditSuccess extends EventEditState {
}