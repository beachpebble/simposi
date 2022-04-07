/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/app_constants.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/bloc/bloc_observer.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';
import 'package:simposi_app_v4/repository/survey_repository.dart';

import 'bloc/app_setup/app_setup_cubit.dart';
import 'bloc/auth/authentication_bloc.dart';
import 'bloc/fcm/fcm_bloc.dart';
import 'bloc/navigator/navigation_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/rsvp_action/rsvp_action_bloc.dart';
import 'calendar/bloc/calendar_bloc.dart';
import 'calendar/checkin/bloc/check_in_bloc.dart';
import 'eventdetails/cubit/event_edit_cubit.dart';
import 'repository/api_service.dart';
import 'repository/calendar_repository.dart';
import 'repository/profile_repository.dart';
import 'simposi_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final observer = SimpleBlocObserver();

  runApp(RepositoryProvider(
    create: (context) => ApiService(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppSetupCubit(context.read())..load()),
        BlocProvider(
            create: (context) => AuthenticationBloc()..add(ReloadAuthEvent()))
      ],
      child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) =>
                  AuthApiService(authenticationBloc: context.read()),
            ),
            RepositoryProvider(
              create: (context) =>
                  ProfileRepository(context.read(), context.read()),
            ),
            RepositoryProvider(
              create: (context) => CalendarRepository(context.read()),
            ),
            RepositoryProvider(
              create: (context) => SurveyRepository(context.read()),
            ),
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider(
                lazy: false, create: (context) => FcmBloc(context.read())),
            BlocProvider(
                create: (context) => ProfileBloc(
                      context.read<AuthenticationBloc>(),
                      context.read(),
                      context.read(),
                      context.read(),
                    )..add(ProfileReload())),
            BlocProvider(
                create: (context) =>
                    RegistrationCubit(profileRepository: context.read())),
            BlocProvider(
                create: (context) =>
                    EventEditCubit(calendarRepository: context.read())),
            BlocProvider(
                create: (context) => RsvpBloc(context.read(), context.read(),
                    context.read(), context.read())
                  ..add(RefreshRequested(
                      DateTime.now().subtract(
                          Duration(days: AppConstants.CALENDAR_DAYS_INTERVAL)),
                      DateTime.now().add(Duration(
                          days: AppConstants.CALENDAR_DAYS_INTERVAL))))),
            BlocProvider(create: (context) => CalendarBloc(context.read())),
            BlocProvider(
                create: (context) => RsvpActionBloc(
                    rsvpBloc: context.read(),
                    calendarRepository: context.read())),
            BlocProvider(
                create: (context) =>
                    CheckInBloc(calendarRepository: context.read())),
            BlocProvider(
                create: (context) => SurveyBloc(
                      profileBloc: context.read(),
                      surveyRepository: context.read(),
                    )),
            BlocProvider(
                create: (context) => NavigationBloc(
                    context.read(), context.read(), context.read())),
          ], child: SimposiApp())),
    ),
  ));
}
