/*
*  socialsscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_router.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'calendarbackground.dart';
// import '../theme/elements/calendarbackground.dart';

class SocialsScreen extends StatelessWidget {
  const SocialsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: 'Socials',
          simposiSubTitle: const Text('Month'),
          simposiAction: TextButton(
            child: const Text(
              'Meet Now',
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () =>
                AutoRouter.of(context).push(const CreateEvent1Route()),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          // TODO: Enable IF Have Events show calendar ELSE show Background
          children: const [
            SimposiCalendarBackground(),
//            SimposiCalendar(),
          ],
        ),
      );
}
