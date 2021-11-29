import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/model/survey.dart';
import 'package:simposi_app_v4/model/survey_required.dart';
import 'package:simposi_app_v4/repository/survey_repository.dart';

part 'survey_event.dart';

part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyRepository _surveyRepository;
  ProfileBloc _profileBloc;

  List<SurveyRequired> _required = [];

  SurveyBloc(
      {required SurveyRepository surveyRepository,
      required ProfileBloc profileBloc})
      : this._surveyRepository = surveyRepository,
        this._profileBloc = profileBloc,
        super(SurveyInitial()) {
    on<SurveyEvent>((event, emit) async {
      if (state is SurveyRefreshEvent) {
        emit(SurveyListLoading());
        _required = await _surveyRepository.getAllSurveyRequests();
        SurveyRequired current  = _required.first;
        //_required.remove(current);
        emit(SurveyProcess(current));
      } else if (state is SurveySendEvent) {
        emit(SurveyListLoading());
        _required = await _surveyRepository.getAllSurveyRequests();
        SurveyRequired current  = _required.first;
        _required.remove(current);
        emit(SurveyProcess(current));
      }
    });
  }
}
