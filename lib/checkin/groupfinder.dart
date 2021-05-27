/*
*  groupfinder.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


class GroupFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: BasicFormAppBar(),

    body: Center(
        child: Column(
          children: [
            Text('Group Finder'),
            SizedBox(height: 10),
            BigButton(
                buttonLabel: 'Chat',
                buttonColor: SimposiAppColors.simposiLightText,
                textColor: SimposiAppColors.simposiDarkGrey,
                buttonAction: () => {
                  Navigator.of(context).pushNamed('/groupfinderchat'),
                },),
            SizedBox(height: 10),
            BigButton(
              buttonLabel: 'Affinity Rating',
              buttonColor: SimposiAppColors.simposiLightText,
              textColor: SimposiAppColors.simposiDarkGrey,
              buttonAction: () => {
                Navigator.of(context).pushNamed('/affinityrating'),
              },),
          ],
        )),
  );
}
