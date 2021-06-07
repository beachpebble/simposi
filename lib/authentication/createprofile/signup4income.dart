/*
*  signup5whoearn.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import '../../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class SignUpForm5 extends StatelessWidget {
  double progress = 0.55;

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
                Text('Income Bracket...',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),),
                SizedBox(height: 20),

                // TODO: Convert to Toggle Buttons
                // iGen Button
                BigGBSelectButton(
                    buttonLabel: 'Less than \$35k',
                    buttonAction: null),
                SizedBox(height: 10),
                // Millennial Button
                BigGBSelectButton(
                    buttonLabel: '\$35k to \$50k',
                    buttonAction: null),
                SizedBox(height: 10),
                // Gen X Button
                BigGBSelectButton(
                    buttonLabel: '\$50k to \$75k',
                    buttonAction: null),
                SizedBox(height: 10),
                // Boomer Button
                BigGBSelectButton(
                    buttonLabel: '\$75k to \$100k',
                    buttonAction: null),
                SizedBox(height: 10),
                // Silent Button
                BigGBSelectButton(
                    buttonLabel: '\$100 to \$150k',
                    buttonAction: null),
                SizedBox(height: 10),
                // Silent Button
                BigGBSelectButton(
                    buttonLabel: '\$150k +',
                    buttonAction: null),
                SizedBox(height: 10),
                // Silent Button
                BigGBSelectButton(
                    buttonLabel: 'Select All',
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

              // TODO: Disable button until user has selected at least one income
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup6'),
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

