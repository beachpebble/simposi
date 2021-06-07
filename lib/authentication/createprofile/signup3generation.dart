/*
*  signup4generation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class SignUpForm4 extends StatelessWidget {
  double progress = 0.44;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,

    appBar: BasicFormAppBar(),

    body: Column(
      children: [
        SizedBox(height: 45),
        Container(
          child: LinearProgressIndicator(
            value: progress,
            valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
            backgroundColor: SimposiAppColors.simposiFadedBlue,
          ),
        ),

        SizedBox(height: 70),

        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: Column(
              children: [

                // Header
                Text('Generation...',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),),
                SizedBox(height: 20),

                // TODO: Convert to Toggle Buttons
                // iGen Button
                BigGBSelectButton(
                  buttonLabel: 'iGen (1996 - Present)',
                  buttonAction: null),
                SizedBox(height: 10),
                // Millennial Button
                BigGBSelectButton(
                  buttonLabel: 'Millennial (1981 - 1995)',
                  buttonAction: null),
                SizedBox(height: 10),
                // Gen X Button
                BigGBSelectButton(
                  buttonLabel: 'Gen X (1965 - 1980)',
                  buttonAction: null),
                SizedBox(height: 10),
                // Boomer Button
                BigGBSelectButton(
                  buttonLabel: 'Boomer (1946 - 1964)',
                  buttonAction: null),
                SizedBox(height: 10),
                // Silent Button
                BigGBSelectButton(
                  buttonLabel: 'Silent (1928 - 1945)',
                  buttonAction: null),

              ],
            ),
          ),
        ),

        // Continue Button
        Container(
          padding: EdgeInsets.all(40),
          child:
          Column(
            children: [

              // TODO: Disable Button until user has selected a generation
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup5'),
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ),
  );
}
