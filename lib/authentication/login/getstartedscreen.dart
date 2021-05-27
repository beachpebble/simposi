/*
*  getstartedscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../authenticationwidgets/privacytoufooter.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: SimposiAppColors.simposiDarkBlue,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.contain,
              alignment: Alignment.topLeft
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // LOGIN FORWARD BUTTON
                Container(
                    height: 100,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: LoginForwardTextButton()),

                // BODY
                Container(
                  height: 350,
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'simposi',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Muli',
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(width: 10),
                          Image.asset("assets/images/logo.png")
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'A new way to match and meet people \n with the same interests.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          GetStartedButton(),
                        ],
                      ),
                    ],
                  ),
                ),

                // FOOTER
                Container(
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: PrivacyTOUFooter(
                    footerColor: Colors.white,
                  ),
                ),
              ]),
        ),
      );
}
