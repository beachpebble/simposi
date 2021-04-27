/*
*  socialsscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'calendarbackground.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
// import '../theme/elements/calendarbackground.dart';

class SocialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: 'Socials',
          simposiSubTitle: Text('Month',
          style: TextStyle(
            color: SimposiAppColors.simposiLightText,
            fontSize: 13,
            ),
          ),
          simposiAction: SimposiTextButton(
            buttonLabel: 'Meet Now',
            nextPage: '/eventlist',
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          // TODO: Enable IF Have Events show calendar ELSE show Background
          children: [
            SimposiCalendarBackground(),
//            SimposiCalendar(),
          ],
        ),
      );
}
