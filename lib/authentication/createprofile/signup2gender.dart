/*
*  signup2gender.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

class SignUpForm2 extends StatelessWidget {
  double progress = 0.22;
  // NOTE: Progress Bar is top widget in content and is extended behind a Transparent AppBar.
  // This is not a great solution but simplest I could conceive of, it will cause display to be weird on non-notched phones

git
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

                // Header Title
                Text('I indentify as...',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: SimposiAppColors.simposiDarkGrey,
                ),),
                SizedBox(height: 20),

                // TODO: Convert to Toggle Buttons
                // Single Select Gender Buttons
                BigGBSelectButton(
                  buttonLabel: 'Man',
                  buttonAction: null),
                SizedBox(height: 10),
                BigGBSelectButton(
                  buttonLabel: 'Woman',
                  buttonAction: null),


                SizedBox(height: 30),
                // Also Member Divider
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                          endIndent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                    ),
                    Text('Also member of',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                      fontSize: 13,
                    ),),
                    Expanded(
                        child: Divider(
                          indent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // TODO: Convert to MultiSelect List (right now only one option)
                // Multi-Select Community Buttons
                BigGBSelectButton(
                  buttonLabel: 'LGBTQ',
                  buttonAction: null),

              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(40),
          child:
          Column(
            children: [

              // TODO: Disable button until user has selected a gender (LGBTQ optional)
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup3'),
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    ),
  );
}
