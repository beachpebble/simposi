/*
*  simposiappbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/widgets/simposihome.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';


class SimposiAppBar extends StatelessWidget with PreferredSizeWidget {
  // Set Variables
  final Size preferredSize;
  final simposiTitle;
  final simposiSubTitle;
  final simposiAction;

  SimposiAppBar({
    required this.simposiTitle,
    this.simposiSubTitle,
    required this.simposiAction,
    Key, key
  })
      : preferredSize = Size.fromHeight(70),
        super(key: key);

  get simposiNavTab => null;

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      toolbarHeight: 75,
      backgroundColor: Colors.white,
      foregroundColor: SimposiAppColors.simposiDarkGrey,
      title: Container(
        height: 68,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              simposiTitle,
              style: TextStyle(
                color: SimposiAppColors.simposiDarkGrey,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            //TODO: Ensure Title stays in same place if SubTitle does not exist
            Column(
              children: [
                if (simposiSubTitle != null)
                  simposiSubTitle,
                SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [simposiAction]
    );
  }
}

