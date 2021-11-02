/*
*  formappbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../../../app_router.dart';
import '../theme.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';


// JUST A BACK BUTTON APP BAR
class BasicFormAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;

  // Initiate Variables
  BasicFormAppBar({Key, key})
      : preferredSize = Size.fromHeight(70),
        super(key: key);

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
          return BackButton(
            color: SimposiAppColors.simposiDarkGrey,
          );
        },
      ),
    );
  }
}


// TITLE AND TWO TEXT BUTTONS BACK AND NEXT
class HeaderFormAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;
  final headerTitle;
  final popPage;
  final nextButtonLabel;

  // Initiate Variables
  HeaderFormAppBar({
    Key? key,
    required this.headerTitle,
    required this.popPage,
    required this.nextButtonLabel,
  })
      : preferredSize = Size.fromHeight(70),
        super(key: key);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: SimposiAppColors.simposiDarkGrey,

      title: Text(headerTitle,
          style: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
      ),
      leading: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () => {
                Navigator.of(context).pop(popPage),
              },
              child: Text('Cancel',
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
        onPressed: () => {
      AutoRouter.of(context)
          .replace(SimposiHomeRoute())
        },
        child: Text(nextButtonLabel,
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
