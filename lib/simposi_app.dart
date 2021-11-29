import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/navigator/navigation_bloc.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';

import 'authentication/login/app_setup_screen.dart';
import 'authentication/login/splash_screen.dart';
import 'global/theme/theme.dart';

class SimposiApp extends StatefulWidget {
  @override
  _SimposiAppState createState() => _SimposiAppState();
}

class _SimposiAppState extends State<SimposiApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.light,
      theme: SimposiThemes.lightTheme,
      darkTheme: SimposiThemes.darkTheme,
      builder: (context, router) => BlocBuilder<AppSetupCubit, AppSetupState>(
        builder: (context, state) {
          if (state is AppSetupLoaded) {
            return BlocListener<NavigationBloc, NavigationState>(
                listener: (context, state) {
                  if (state is NavigationLogin) {
                    _appRouter.replaceAll(
                        [GetStartedScreenRoute(), LoginScreenRoute()]);
                  } else if (state is NavigationMain) {
                    _appRouter.replace(SimposiHomeRoute());
                  } else if (state is NavigationNotAuth) {
                    _appRouter.replace(GetStartedScreenRoute());
                  } else if (state is NavigationOnEvent) {
                    _appRouter
                        .replaceAll([GroupFinderRoute(event: state.event)]);
                  } else if (state is NavigationSurveyNeed) {
                    context.read<SurveyBloc>().add(SurveyRefreshEvent());
                    _appRouter
                        .replaceAll([SurveyScreenRoute()]);
                  }

                  // if (state is NotAuthenticated) {
                  //   if (state.loginScreen) {
                  //     //TODO create notification about logout
                  //     _appRouter.replaceAll(
                  //         [GetStartedScreenRoute(), LoginScreenRoute()]);
                  //   } else {
                  //     _appRouter.replace(GetStartedScreenRoute());
                  //   }
                  // } else if (state is Authenticated) {
                  //   _appRouter.replace(SimposiHomeRoute());
                  // }
                },
                child: router!);
          } else if (state is AppSetupError) {
            return AppSetupErrorScreen(error: state.error);
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
