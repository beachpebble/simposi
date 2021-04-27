/*
*  privacy.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import '../global/routegenerator.dart';

class PrivacyScreen extends StatelessWidget {
  double progress = 0.22;



  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: BasicFormAppBar(),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progress,
              valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
              backgroundColor: SimposiAppColors.simposiFadedBlue,
            ),
          ],
        ),
      );
}
