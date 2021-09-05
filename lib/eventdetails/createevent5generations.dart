/*
*  createevent5generations.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class CreateEvent5 extends StatelessWidget {
  double progress = 0.70;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,
    appBar: CancelFormAppBar(),
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
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: Column(
              children: [
                // TODO: Convert to Toggle Buttons (copy generations implementation from authentication)
                // iGen Button
                BigGBSelectButton(
                  buttonLabel: 'iGen (1996 - Present)',
                  buttonAction: null),
                const SizedBox(height: 10),
                // Millennial Button
                BigGBSelectButton(
                  buttonLabel: 'Millennial (1981 - 1995)',
                  buttonAction: null),
                const SizedBox(height: 10),
                // Gen X Button
                BigGBSelectButton(
                  buttonLabel: 'Gen X (1965 - 1980)',
                  buttonAction: null),
                const SizedBox(height: 10),
                // Boomer Button
                BigGBSelectButton(
                  buttonLabel: 'Boomer (1946 - 1964)',
                  buttonAction: null),
                const SizedBox(height: 10),
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
              // TODO: Disable Button until user has selected generation for who they want to meet
              // TODO: THIS SCREEN CAN BE SAVED AS A REUSABLE SETTING. Make screen reusable by hiding the This Event Only button when user is coming from profile menu.
              // TODO: IF user has saved settings PREPOPULATE SCREEN SETTINGS, HIDE THIS EVENT ONLY BUTTON, HIDE SAVE FOR ALL EVENTS BUTTON SHOW CONTINUE BUTTON INSTEAD.
              // TODO: IF user changes prepoulated setting Hide Continue button and SHOW This Event Only & Save for all Events buttons
              BigGBSelectButton(
                buttonLabel: 'This Event Only',
                buttonAction: () => {
                  Navigator.of(context).pushNamed('/createevent6'),
                },
              ),
              const SizedBox(height: 10),
              BigGBSelectButton(
                buttonLabel: 'Save for all Events',
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
