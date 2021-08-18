/*
*  createevent5generations.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class CreateEvent5 extends StatelessWidget {
  double progress = 0.70;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,
    appBar: BasicFormAppBar(),
    body: Column(
      children: [
        // Header
        Container(
          child: Column(
            children: [
              const SizedBox(height: 45),
              LinearProgressIndicator(
                value: progress,
                valueColor: const AlwaysStoppedAnimation(
                    SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
              const SizedBox(height: 70),
              Text(
                'Who do you want to meet ?',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        // Body
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: Column(
              children: [
                // TODO: Convert to Toggle Buttons (copy generations implementation from authentication)
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

        // Footer
        Container(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
          child:
          Column(
            children: [
              // TODO: Disable Button until user has selected a generation
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () => {
                  Navigator.of(context).pushNamed('/createevent6'),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
