/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'global/theme/elements/simposihome.dart';
import 'package:simposi_app_v4/global/routegenerator.dart';

// Simposi App Config
void main() => runApp(MaterialApp(
  themeMode: ThemeMode.light,
  theme: SimposiThemes.lightTheme,
  darkTheme: SimposiThemes.darkTheme,
  initialRoute: '/',
  onGenerateRoute: RouteGenerator.generateRoute,
  ),
);


