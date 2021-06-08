import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/repository/api_service.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

import 'global/routegenerator.dart';
import 'global/theme/theme.dart';
import 'repository/auth_repository.dart';

class SimposiApp extends StatefulWidget {
  @override
  _SimposiAppState createState() => _SimposiAppState();
}

class _SimposiAppState extends State<SimposiApp> {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthenticationBloc(
                    authManager: context.read<AuthRepository>())
                  ..add(ReloadAuthEvent()),
              ),
            ],
            child: MaterialApp(
                themeMode: ThemeMode.light,
                theme: SimposiThemes.lightTheme,
                darkTheme: SimposiThemes.darkTheme,
                home: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is NotAuthenticated) {
                        _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            "/start", (Route<dynamic> route) => false);
                      } else if (state is Authenticated) {
                        _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            "/home", (Route<dynamic> route) => false);
                      }
                    },
                    child: WillPopScope(
                      onWillPop: () async {
                        if (_navigatorKey.currentState?.canPop() == true) {
                          _navigatorKey.currentState?.pop();
                          return false;
                        } else {
                          return true;
                        }
                      },
                      child: Navigator(
                        key: _navigatorKey,
                        initialRoute: '/',
                        onGenerateRoute: RouteGenerator.generateRoute,
                      ),
                    )))));
  }
}
