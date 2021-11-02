/*
*  socialsscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import '../app_router.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'calendarbackground.dart';
// import '../theme/elements/calendarbackground.dart';

class SocialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: 'Socials',
          simposiSubTitle: Text('Month'),
          simposiAction: TextButton(
            child: Text('Meet Now',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onPressed: () => {
              AutoRouter.of(context)
                  .push(CreateEvent1Route())
            },
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
