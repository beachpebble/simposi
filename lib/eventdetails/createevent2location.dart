/*
*  createevent2location.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:simposi_app_v4/global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';

// TODO: THIS SCREEN IS JUST TO DISPLAY VISUAL. DEPRECATED LAYOUT.
// TODO: Please enable functionality on the CreateEvent2 Folder UI and delete this one.
class CreateEvent2 extends StatelessWidget {
  double progress = 0.28;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,

        appBar: CancelFormAppBar(),

        body: Column(
          children: [
            const SizedBox(height: 45),
            Container(
              child: LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
            ),

            const SizedBox(height: 70),

            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: Column(
                  children: [

                    // Header Title
                    Text('Where do you want to meet?',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),),
                    SizedBox(height: 20),


                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(40),
              child:
              Column(
                children: [

                  // TODO: Disable Button until user has selected gender for who they want to meet
                  BigGBSelectButton(
                    buttonLabel: 'Continue',
                    buttonAction: () =>
                    {
                      Navigator.of(context).pushNamed('/createevent3'),
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