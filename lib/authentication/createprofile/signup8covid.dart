/*
*  signup8covid.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/authentication/authenticationwidgets/agreement.dart';

class SignUpForm8 extends StatelessWidget {
  double progress = 0.88;

  List<Agreement> agreements = [
    Agreement(agreementtext: 'I have read & understand my local regulations and the CDC Guidelines.'),
    Agreement(agreementtext: 'I will stay home if I think I have Covid-19, have a cough or fever or am just not feeling well.'),
    Agreement(agreementtext: 'I will carry a face mask at all times and wear it is as required or recommended by the activity hosts, the CDC and/or local guidelines.'),
    Agreement(agreementtext: 'I will maintain a safe social distance while attending Simposi activities.'),
    Agreement(agreementtext: 'I will wash and/or sanitize my hands as frequently as possible while attending a Simposi activity.'),
  ];

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
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),),
                SizedBox(height: 20),

                Text('You must agree to follow the CDC guidelines \n and your local regulations to use Simposi.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                Container(
                  child: Column(
                    children: [
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
                      SizedBox(height: 10),
                      Row(
                          children: [
                            Flexible(
                              child: Text('I have read & understand my local regulations and the CDC Guidelines.',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            AgreeButton(),

                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                            AgreeButton(),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                            AgreeButton(),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                            AgreeButton(),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                            AgreeButton(),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                            AgreeButton(),
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: SimposiAppColors.simposiLightText,
                      ),
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
                buttonLabel: 'Finish',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/signup9'),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
