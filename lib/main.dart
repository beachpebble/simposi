/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/utils/bloc_observer.dart';

import 'simposi_app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    SimposiApp(),
  );
}
