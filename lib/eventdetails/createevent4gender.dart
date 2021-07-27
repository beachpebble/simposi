/*
*  createevent4gender.dart
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


class CreateEvent4 extends StatelessWidget {
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
                Text('Who do you want to meet?',
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
                    Text('Also Members of',
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

              // TODO: Disable Button until user has selected gender for who they want to meet
              // TODO: Make screen reusable by changing the Continue button to a save button when user comes from profile menu?
              // TODO: IF user does NOT have saved invitation settings, display dialog asking if they want to save these settings.
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/createevent5'),
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

