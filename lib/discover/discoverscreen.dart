/*
*  discoverscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import 'discovercarddeck.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: 'Discover',
          simposiAction: SimposiTextButton(
            buttonLabel: 'Meet Now',
            // nextPage: '/createevent',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            onClick: () {},
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            DiscoverCardDeck(),
          ],
        ),
      );
}
