/*
*  calendarbackground.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

class SimposiCalendarBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/backgroundcalendar.png",
          ),
        ),
        SizedBox(height: 30.0),
        Center(
          child: Text(
            "Hmm.. No plans?",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(height: 5.0),
        Center(
          child: Text(
            "Meet new people by inviting \nthem to join you!",
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
        ),
        SizedBox(height: 20.0),
        SmallPinkButton(
            buttonLabel: 'Meet Now',
            nextPage: '/createevent'
        ),
      ],
    );
  }
}


