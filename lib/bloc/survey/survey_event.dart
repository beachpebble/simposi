part of 'survey_bloc.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();
}

class SurveyRefreshEvent extends SurveyEvent {
  @override
  List<Object?> get props => [];
}

class SurveySendEvent extends SurveyEvent {

  final Survey survey;

  const SurveySendEvent(this.survey);
  @override
  List<Object?> get props => [survey];
}