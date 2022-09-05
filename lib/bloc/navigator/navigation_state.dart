part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationLogin extends NavigationState {}

class NavigationMain extends NavigationState {}

class NavigationNotAuth extends NavigationState {}

class NavigationOnEvent extends NavigationState {
  final Event event;

  NavigationOnEvent(this.event);
}

class NavigationSurveyNeed extends NavigationState {}
