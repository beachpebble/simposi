/*
*  alertsbackground.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';



class SimposiAlertsBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/backgroundbell.png",
          ),
        ),
        const SizedBox(height: 30.0),
        Center(
          child: Text(
            "No Notifications",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 5.0),
        const Center(
          child: Text(
            "Check again later or invite others \n to meet you instead.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const SmallPinkButton(
            buttonLabel: 'Meet Now',
            nextPage: '/createevent'),
      ],
    );
  }
}
