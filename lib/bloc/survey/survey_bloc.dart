import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/model/survey.dart';
import 'package:simposi_app_v4/model/survey_required.dart';
import 'package:simposi_app_v4/repository/survey_repository.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository _surveyRepository;
  final ProfileBloc _profileBloc;

  List<SurveyRequired> _required = [];

  SurveyBloc(
      {required SurveyRepository surveyRepository,
      required ProfileBloc profileBloc})
      : _surveyRepository = surveyRepository,
        _profileBloc = profileBloc,
        super(SurveyInitial()) {
    on<SurveyEvent>((event, emit) async {
      if (event is SurveyRefreshEvent) {
        await _surveyRefresh(event, emit);
      } else if (event is SurveySendEvent) {
        await _surveySend(event, emit);
      }
    });
  }

  Future<void> _surveyRefresh(
      SurveyRefreshEvent event, Emitter<SurveyState> emit) async {
    try {
      emit(SurveyListLoading());
      _required = await _surveyRepository.getAllSurveyRequests();
      if (_required.isNotEmpty) {
        final current = _required.first;
        emit(SurveyProcess(current));
      } else {
        _profileBloc.add(const ProfileReload());
      }
    } on Exception catch (e) {
      emit(SurveyError(e));
    }
  }

  Future<void> _surveySend(
      SurveySendEvent event, Emitter<SurveyState> emit) async {
    try {
      emit(SurveyListLoading());
      await _surveyRepository.submitSurvey(event.survey);
      final current = _required.first;
      _required.remove(current);
      if (_required.isNotEmpty) {
        final newCurrent = _required.first;
        emit(SurveyProcess(newCurrent));
      } else {
        _profileBloc.add(const ProfileReload());
      }
    } on Exception catch (e) {
      emit(SurveyError(e));
    }
  }
}
