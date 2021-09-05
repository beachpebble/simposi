/*
*  createevent4gender.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';


class CreateEvent4 extends StatefulWidget {
  final bool editMode;

  const CreateEvent4({Key? key, this.editMode = false}) : super(key: key);

  @override
  _CreateEvent4State createState() => _CreateEvent4State();
}

class _CreateEvent4State extends State<CreateEvent4> {
  double progress = 0.56;

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
                valueColor:
                const AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
              const SizedBox(height: 70),
              Text('Who do you want to meet ?',
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
                BigGBSelectButton(
                    buttonLabel: 'Man', //TODO Localize
                    isSelected: false, //TODO Enable State
                    buttonAction: () {
                      // _selectGender(Gender.Male);
                    }),
                const SizedBox(height: 10),
                BigGBSelectButton(
                    buttonLabel: 'Woman', //TODO Localize
                    isSelected: false, //TODO Enable State
                    buttonAction: () {
                      // _selectGender(Gender.Female);
                    }),

                const SizedBox(height: 30),
                // Also Member Divider
                Row(
                  children: [
                    Expanded(
                      child: const Divider(
                        endIndent: 10,
                        color: SimposiAppColors.simposiLightText,
                      ),
                    ),
                    const Text(
                      'Also member of',
                      style: const TextStyle(
                        color: SimposiAppColors.simposiLightText,
                        fontSize: 13,
                      ),
                    ),
                    Expanded(
                      child: const Divider(
                        indent: 10,
                        color: SimposiAppColors.simposiLightText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Multi-Select Community Buttons
                BigGBSelectButton(
                    buttonLabel: 'LGBTQ', //TODO Localize
                    isSelected: false, //TODO Enable State
                    buttonAction: () {
                      //_selectLgbt();
                    }),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
          child:
          Column(
            children: [
              // TODO: Disable Button until user has selected gender for who they want to meet
              // TODO: THIS SCREEN CAN BE SAVED AS A REUSABLE SETTING. Make screen reusable by hiding the This Event Only button when user is coming from profile menu.
              // TODO: IF user has saved settings PREPOPULATE SCREEN SETTINGS, HIDE THIS EVENT ONLY BUTTON, HIDE SAVE FOR ALL EVENTS BUTTON SHOW CONTINUE BUTTON INSTEAD.
              // TODO: IF user changes prepoulated setting Hide Continue button and SHOW This Event Only & Save for all Events buttons
              BigGBSelectButton(
                buttonLabel: 'This Event Only',
                buttonAction: () => {
                  Navigator.of(context).pushNamed('/createevent5'),
                },
              ),
              const SizedBox(height: 10),
              BigGBSelectButton(
                buttonLabel: 'Save for all Events',
                buttonAction: () => {
                  Navigator.of(context).pushNamed('/createevent5'),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

