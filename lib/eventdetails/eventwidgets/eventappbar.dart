/*
*  eventappbar.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TODO: Enable Progress Bar for Signup Screens
// With Progress Bar
class EventAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;

  // Initiate Variables
  EventAppBar({Key, key})
      : preferredSize = Size.fromHeight(60),
        super(key: key);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: SimposiAppColors.simposiDarkGrey,
      leading: Builder(
        builder: (BuildContext context) {

          // CLOSE BUTTON
          return IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.close,
                color: SimposiAppColors.simposiLightText),
            onPressed: () {Navigator.pop(context);},
          );
        },
      ),
      actions: [

        // SHARE BUTTON
        IconButton(
          alignment: Alignment.center,
          visualDensity: VisualDensity(
              horizontal: -2.0,
          ),
          padding: EdgeInsets.all(0),
            icon: Icon(Icons.ios_share,
            color: SimposiAppColors.simposiLightText),
            onPressed: () {},
        ),

        // MENU BUTTON
        FocusedMenuHolder(
          menuItems: [
            FocusedMenuItem(
              // TODO: Enable Cancel RSVP Button
                title: Text('Cancel RSVP',
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkBlue,
                ),),
                onPressed: () {},
            ),

            FocusedMenuItem(
              // TODO: Enable Report Social Button
              title: Text('Report Social',
              style: TextStyle(
                color: SimposiAppColors.simposiDarkBlue,
              ),),
              onPressed: () {},
            ),
          ],
          blurBackgroundColor: Colors.black45,
          openWithTap: true,
          onPressed: () {},
          child: Icon(Icons.more_horiz,
                color: SimposiAppColors.simposiLightText),
          ),
        SizedBox(width: 20),
      ],
    );
  }
}
