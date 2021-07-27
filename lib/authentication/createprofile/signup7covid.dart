/*
*  signup7covid.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

class SignUpForm7 extends StatelessWidget {
  double progress = 0.88;

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

        SizedBox(height: 50),

        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [

                // Header Title
                Text('Health and Safety Agreement',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 20),

                Text('You must agree to follow the CDC guidelines \n and your local regulations to use Simposi.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                          children: [
                            Flexible(
                              child: Text('I have read & understand my local regulations and the CDC Guidelines.',
                                textAlign: TextAlign.start,
                              ),
                            ),

                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Flexible(
                              child: Text('I will stay home if I have a cough or fever or am just not feeling well.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Flexible(
                              child: Text('I will carry a face mask at all times and wear it is as required by the activity hosts, the CDC and/or local guidelines.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Flexible(
                              child: Text('I will maintain a safe social distance while attending Simposi activities.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Flexible(
                              child: Text('I will wash and/or sanitize my hands as frequently as possible while attending a Simposi activity.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Flexible(
                              child: Text('I will notify Simposi immediately if I test positive for Covid-19 after attending an activity.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 60),
          child:
          Column(
            children: [

              // TODO: Disable Button until user has selected gender for who they want to meet
              BigGBSelectButton(
                buttonLabel: 'Accept Agreement',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup8'),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
