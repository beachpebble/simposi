/*
*  signup3iwanttomeet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

class SignUpForm3 extends StatelessWidget {
  double progress = 0.33;

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
                Text('I want to meet...',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),),
                SizedBox(height: 20),

                // TODO: Convert to Toggle Buttons
                // Single Select Gender Buttons
                BigGBSelectButton(
                    buttonLabel: 'Men Only',
                    buttonAction: null),
                SizedBox(height: 10),
                BigGBSelectButton(
                    buttonLabel: 'Women Only',
                    buttonAction: null),
                SizedBox(height: 10),
                BigGBSelectButton(
                    buttonLabel: 'Everyone',
                    buttonAction: null),
                SizedBox(height: 20),
                Text('Selecting a gender will turn off all invitations for mixed gender events.',
                  textAlign: TextAlign.center,)


              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(40),
          child:
          Column(
            children: [

              // TODO: Disable Button until user has selected gender for who they want to meet
              // TODO: Make screen resuable by changing the Continue button to a save button when user comes from profile menu?
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup4'),
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
