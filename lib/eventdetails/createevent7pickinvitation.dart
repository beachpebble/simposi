/*
*  createevent7pickinvitation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';


class CreateEvent7 extends StatelessWidget {
  double progress = 0.77;

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
                Text('Pick an Invitation',
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
          padding: EdgeInsets.all(40),
          child:
          Column(
            children: [

              // TODO: Disable Button until user has selected gender for who they want to meet
              BigGBSelectButton(
                buttonLabel: 'Create Event',
                buttonAction: () =>
                {
                  Navigator.of(context).pushReplacementNamed('/home'),
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
