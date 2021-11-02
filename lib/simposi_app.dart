import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';

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
      routerDelegate:_appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.light,
      theme: SimposiThemes.lightTheme,
      darkTheme: SimposiThemes.darkTheme,
      builder: (context, router) => BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is NotAuthenticated) {
            _appRouter.replace(GetStartedScreenRoute());
          } else if (state is Authenticated) {
            _appRouter.replace(SimposiHomeRoute());
          }
        },
        child: router!,
      ),
    );
  }
}
