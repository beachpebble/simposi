/*
*  formappbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// JUST A BACK BUTTON APP BAR
class BasicFormAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  @override
  final Size preferredSize;

  // Initiate Variables
  BasicFormAppBar({super.key}) : preferredSize = const Size.fromHeight(70);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      foregroundColor: SimposiAppColors.simposiDarkGrey,
      leading: Builder(
        builder: (BuildContext context) {
          return const BackButton(
            color: SimposiAppColors.simposiDarkGrey,
          );
        },
      ),
    );
  }
}

class HeaderFormAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  @override
  final Size preferredSize;
  // ignore: prefer_typing_uninitialized_variables
  final headerTitle;
  // ignore: prefer_typing_uninitialized_variables
  final nextButtonLabel;
  final VoidCallback onNext;

  // Initiate Variables
  HeaderFormAppBar({
    Key? key,
    required this.headerTitle,
    required this.nextButtonLabel,
    required this.onNext,
  })  : preferredSize = const Size.fromHeight(70),
        super(key: key);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: SimposiAppColors.simposiDarkGrey,
      title: Text(
        headerTitle,
        style: const TextStyle(
          color: SimposiAppColors.simposiDarkGrey,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () {
                AutoRouter.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkBlue,
                  fontSize: 17,
                ),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onNext,
          child: const Text(
            "Submit",
            style: TextStyle(
              fontSize: 17,
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),
        ),
      ],
    );
  }
}
