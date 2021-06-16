/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/utils/bloc_observer.dart';

import 'bloc/auth/authentication_bloc.dart';
import 'repository/api_service.dart';
import 'repository/auth_repository.dart';
import 'repository/profile_repository.dart';
import 'simposi_app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ApiService(authRepository: context.read()),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(context.read()),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authManager: context.read())
                ..add(ReloadAuthEvent()),
        ),
        BlocProvider(
          create: (context) =>
          RegistrationCubit(profileRepository: context.read())..preload(),
        ),
      ], child: SimposiApp())));
}
