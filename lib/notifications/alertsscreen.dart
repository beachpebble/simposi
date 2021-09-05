/*
*  alertsscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import '../global/widgets/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'alertsbackground.dart';

class AlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: 'Alerts',
          // TODO: Hide Settings here for now, descoping this for the time being
          simposiAction: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                icon: Icon(Icons.settings_outlined,
                    color: SimposiAppColors.simposiLightText,
                    size: 30),
                onPressed: () => {
                  Navigator.of(context).pushNamed('/profilemenu'),
                }),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SimposiAlertsBackground()],
        ),
      );
}
