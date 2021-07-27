import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log(transition.toString(), name: "BLOC");
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    developer.log(change.toString(), name: "BLOC");
    super.onChange(bloc, change);
  }
}