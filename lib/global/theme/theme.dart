/*
*  theme.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'appcolors.dart';

class SimposiThemes {
  static final lightTheme = ThemeData(

    // Simposi Font Family
    fontFamily: 'Muli',

    // Simposi Background
    scaffoldBackgroundColor: SimposiAppColors.greyBackground,

    // Simposi Color Scheme
      colorScheme: ColorScheme.light(
        primary: SimposiAppColors.simposiLightText,
        primaryVariant: SimposiAppColors.simposiDarkGrey,
        onPrimary: Colors.white,
        secondary: SimposiAppColors.simposiDarkBlue,
        secondaryVariant: SimposiAppColors.simposiFadedBlue,
        onSecondary: Colors.white,
        background: SimposiAppColors.greyBackground,
        onBackground: SimposiAppColors.simposiDarkGrey,
        surface: Colors.white,
        onSurface: SimposiAppColors.simposiDarkGrey,
        error: Colors.white,
        onError: SimposiAppColors.simposiPink,
      ),

    // Simposi Text Theme
    textTheme: TextTheme(
        // Get Started
        headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
        headline2: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
        // Signup Headers Form Field Headers & Placeholder Headers
        headline3: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
        // Dialog Header Text
        headline4: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
        // Event Details Header
        headline5: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
        // AppBar Header Text
        headline6: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
        // Primary Text in Lists (Event Widgets)
        subtitle1: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
        // Smaller than Subtitle 1 (Event Widget Subtitles)
        subtitle2: TextStyle(fontSize: 15, color: SimposiAppColors.simposiDarkGrey),
        // Body Text Regular
        bodyText1: TextStyle(fontSize: 15, color: SimposiAppColors.simposiLightText),
        // Body Text Light
        bodyText2: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: SimposiAppColors.simposiLightText),
        // Image Text (not used)
        caption: TextStyle(fontSize: 13, color: SimposiAppColors.simposiDarkGrey),
        // Button Text
        button: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
        // AppBar Subheading
        overline: TextStyle(fontSize: 15, color: SimposiAppColors.simposiLightText),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData (
        style: TextButton.styleFrom(
          primary: SimposiAppColors.simposiDarkBlue,
          textStyle: TextStyle(
            fontSize: 17,
          ),
        ),
    ),




  );


// Simposi Dark Theme
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    fontFamily: 'Muli',
  );
}

