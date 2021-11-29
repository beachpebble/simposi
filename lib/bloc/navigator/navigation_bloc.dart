import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';
import 'package:simposi_app_v4/model/event.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  late StreamSubscription authSubscription;
  late StreamSubscription profileSubscription;
  AuthenticationBloc _authBloc;
  ProfileBloc _profileBloc;
  SurveyBloc _surveyBloc;

  NavigationBloc(AuthenticationBloc authBloc, ProfileBloc profileBloc, SurveyBloc surveyBloc)
      : _authBloc = authBloc,
        _profileBloc = profileBloc,
        _surveyBloc = surveyBloc,
        super(NavigationInitial()) {
    authSubscription = authBloc.stream.listen((state) {
      if (state is NotAuthenticated) {
        if (state.loginScreen) {
          add(GotLogin());
        } else {
          add(GotNotAuthenticated());
        }

      } else if (state is Authenticated) {
        add(GotAuthenticated());
      }
    });
    profileSubscription = profileBloc.stream.listen((state) {
      if (state is ProfileOnEvent) {
        if (_authBloc.state is Authenticated) {
          add(GotOnEvent(state.event));
        }
      } else if (state is ProfileLoaded) {
        if (_authBloc.state is Authenticated) {
          add(GotProfileLoaded());
        }
      }else if (state is ProfileOnSurvey) {
        if (_authBloc.state is Authenticated) {
          add(GotOnSurvey());
        }
      }
    });
    on<NavigationEvent>((event, emit) {
      if (event is GotNotAuthenticated) {
        emit(NavigationNotAuth());
      } else if (event is GotAuthenticated) {
        emit(NavigationMain());
      } else if (event is GotOnEvent) {
        emit(NavigationOnEvent(event.event));
      } else if (event is GotProfileLoaded) {
        emit(NavigationMain());
      }else if (event is GotOnSurvey) {
        emit(NavigationSurveyNeed());
      }
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    profileSubscription.cancel();
    return super.close();
  }
}
