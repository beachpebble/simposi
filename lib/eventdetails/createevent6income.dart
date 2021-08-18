/*
*  createevent6income.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class CreateEvent6 extends StatelessWidget {
  double progress = 0.84;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,
    appBar: BasicFormAppBar(),
    body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Column(
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

          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
              child: Column(
                children: [
                  // TODO: Convert to Toggle Buttons (copy same method implemented on authentication screen)
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

                ],
              ),
            ),
          ),

          // Continue Button
          Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
            child:
            Column(
              children: [
                // TODO: Enable this button for select all function
/*                BigGBSelectButton(
                    buttonLabel: 'Select All',
                    isSelected: _selected.length ==
                        context
                            .read<AuthenticationBloc>()
                            .masterData
                            .earnings
                            .length,
                    buttonAction: () {
                      _selectAll();
                    }),*/
                const SizedBox(height: 10),
                // TODO: Disable button until user has selected at least one income
                BigGBSelectButton(
                  buttonLabel: 'Continue',
                  buttonAction: () => {
                    Navigator.of(context).pushNamed('/createevent7'),
                  },
                ),
              ],
            ),
          ),
        ],
      );
    })
  );
}

