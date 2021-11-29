part of 'survey_bloc.dart';

abstract class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => [];
}

class SurveyInitial extends SurveyState {}

class SurveyListLoading extends SurveyState {}

class SurveyError extends SurveyState {
  final dynamic error;

  SurveyError(this.error);

  @override
  List<Object> get props => [error];
}

class SurveyProcess extends SurveyState {
  final SurveyRequired surveyRequired;

  SurveyProcess(this.surveyRequired);

  @override
  List<Object> get props => [surveyRequired];
}

class SurveySendLoading extends SurveyState {}