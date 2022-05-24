/*
*  theme.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'appcolors.dart';

class SimposiThemes {
  static final lightTheme = ThemeData(

    // Simposi Font Family
    fontFamily: 'Muli',

    // Simposi Background
    scaffoldBackgroundColor: SimposiAppColors.greyBackground,

    // Simposi Color Scheme
      colorScheme: const ColorScheme.light(
        primary: SimposiAppColors.simposiLightText,
        onPrimary: Colors.white,
        secondary: SimposiAppColors.simposiDarkBlue,
        onSecondary: Colors.white,
        background: SimposiAppColors.greyBackground,
        onBackground: SimposiAppColors.simposiDarkGrey,
        surface: Colors.white,
        onSurface: SimposiAppColors.simposiDarkGrey,
        error: Colors.white,
        onError: SimposiAppColors.simposiPink,
      ),


    // Simposi Text Theme
    textTheme: const TextTheme(
      // Get Started
      headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
      // App Bar Headers
      headline2: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
      // Signup Headers Form Field Headers & Placeholder Headers
      headline3: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
      // Dialog Header Text
      headline4: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SimposiAppColors.simposiDarkGrey),
      // Event Details Header
      headline5: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SimposiAppColors.simposiDarkGrey),
      // Menu Text
      headline6: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: SimposiAppColors.simposiLightText),
      // Input Text in Fields
      subtitle1: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: SimposiAppColors.simposiLightText),
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

    // Divider
    dividerColor: SimposiAppColors.simposiLightText,

    // Text Button Theme
    textButtonTheme: TextButtonThemeData (
        style: TextButton.styleFrom(
          primary: SimposiAppColors.simposiDarkBlue,
          textStyle: const TextStyle(
            fontSize: 17,
          ),
        ),
    ),


    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      labelStyle: TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      ),

      // INITIAL STATE
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          )),

      // FOCUS STATE
      focusColor: SimposiAppColors.simposiDarkBlue,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiDarkBlue,
          )),

      // FOCUS ERROR STATE
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiPink,
          )
      ),

      // ERROR STATE
      errorStyle: TextStyle(
        color: SimposiAppColors.simposiPink,
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiPink,
          )
      ),
    ),

  );


// Simposi Dark Theme
  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    fontFamily: 'Muli',
  );
}

