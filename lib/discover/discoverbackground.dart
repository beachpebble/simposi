/*
*  discoverbackground.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import '../app_router.dart';

class SimposiDiscoverBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/backgroundcompass.png",
          ),
        ),
        const SizedBox(height: 30.0),
        Center(
          child: Text(
            "No Events Found",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 5.0),
        const Center(
          child: Text(
            "That's everything in your area. \n Reset the deck to browse nearby events again.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20.0),

        // TODO: Enable this to reset the Card Deck
        SmallPinkButton(
            buttonLabel: 'Reset',
            nextPage: () =>
                AutoRouter.of(context).push(const CreateEvent1Route())),
      ],
    );
  }
}
