/*
*  simposiappbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SimposiAppBar extends StatelessWidget with PreferredSizeWidget {
  // Set Variables
  @override
  final Size preferredSize;
  // ignore: prefer_typing_uninitialized_variables
  final simposiTitle;
  // ignore: prefer_typing_uninitialized_variables
  final simposiSubTitle;
  // ignore: prefer_typing_uninitialized_variables
  final simposiAction;

  SimposiAppBar({
    required this.simposiTitle,
    this.simposiSubTitle,
    required this.simposiAction,
    super.key,
  }) : preferredSize = const Size.fromHeight(70);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        elevation: 0.0,
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        foregroundColor: SimposiAppColors.simposiDarkGrey,
        title: SizedBox(
          height: 68,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                simposiTitle,
                style: const TextStyle(
                  color: SimposiAppColors.simposiDarkGrey,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              //TODO: Ensure Title stays in same place if SubTitle does not exist
              Column(
                children: [
                  if (simposiSubTitle != null) simposiSubTitle,
                  const SizedBox(height: 5),
                ],
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [simposiAction]);
  }
}
