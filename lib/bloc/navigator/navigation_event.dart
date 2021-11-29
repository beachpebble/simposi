part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class GotNotAuthenticated extends NavigationEvent{

}
class GotLogin extends NavigationEvent{}
class GotAuthenticated extends NavigationEvent{}
class GotOnEvent extends NavigationEvent{
  final Event event;

  GotOnEvent(this.event);
}
class GotProfileLoaded extends NavigationEvent{}
class GotOnSurvey extends NavigationEvent{}