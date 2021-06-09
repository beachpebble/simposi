import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';

import 'global/routegenerator.dart';
import 'global/theme/theme.dart';

class SimposiApp extends StatefulWidget {
  @override
  _SimposiAppState createState() => _SimposiAppState();
}

class _SimposiAppState extends State<SimposiApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is NotAuthenticated) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
              "/start", (Route<dynamic> route) => false);
        } else if (state is Authenticated) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
              "/home", (Route<dynamic> route) => false);
        }
      },
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: ThemeMode.light,
        theme: SimposiThemes.lightTheme,
        darkTheme: SimposiThemes.darkTheme,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
