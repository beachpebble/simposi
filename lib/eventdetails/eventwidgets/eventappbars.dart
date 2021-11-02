/*
*  eventappbars.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

import '../../app_router.dart';

class EventAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;

  // Initiate Variables
  EventAppBar({Key, key})
      : preferredSize = const Size.fromHeight(60),
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
            icon: const Icon(Icons.close,
                color: SimposiAppColors.simposiLightText),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      actions: [
        // TODO: Enable Share button to open the same bottomsheet with sharing options as is activated by the Invite Friend button in the dialog below (enable same function 2 spots in this file)
        // SHARE BUTTON
        IconButton(
          alignment: Alignment.center,
          visualDensity: const VisualDensity(
            horizontal: -2.0,
          ),
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.ios_share,
              color: SimposiAppColors.simposiLightText),
          onPressed: () {},
        ),

        // TODO: HIDE/SHOW menu options OR swap the menu based on if user created the event. If user created event, then they can edit it or cancel it.
        // TODO: If user is just getting an invite, they can only edit their respose to the invite and not the event.
        // MENU BUTTON
        FocusedMenuHolder(
          menuItems: [
            FocusedMenuItem(
              // TODO: Enable Cancel RSVP Button
              title: const Text(
                'Cancel RSVP',
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkBlue,
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).restorablePush(_dialogBuilder),
            ),
            FocusedMenuItem(
              // TODO: Enable Report Social Button
              title: const Text(
                'Report Social',
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkBlue,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/reportevent'),
            ),
          ],
          blurBackgroundColor: Colors.black45,
          openWithTap: true,
          onPressed: () {},
          child: const Icon(Icons.more_horiz,
              color: SimposiAppColors.simposiLightText),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  // DIALOGUE
  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirm Cancellation'),
          content: Text(
              'Are you sure you want to cancel your RSVP to this activity?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop('Cancel'),
            ),
            // TODO: Enable cancel button to update status of RSVP to Cancelled, this should remove event from calendar
            CupertinoDialogAction(
                child: Text('Confirm'),
                onPressed: () =>
                    AutoRouter.of(context).push(SimposiHomeRoute())),
          ],
        );
      },
    );
  }
}

class InvitationAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;

  // Initiate Variables
  InvitationAppBar({Key, key})
      : preferredSize = Size.fromHeight(60),
        super(key: key);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      leading: Builder(
        builder: (BuildContext context) {
          // CLOSE BUTTON
          return IconButton(
            alignment: Alignment.center,
            icon: const Icon(Icons.close,
                color: SimposiAppColors.simposiLightText),
            onPressed: () {
              Navigator.pop(context);
            },
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
          padding: const EdgeInsets.all(0),
          // TODO: Enable share button to send deep link to event (discover card) opens bottom sheet so user can select method to share copy url, email, sms, whatsapp, messenger, etc
          icon: const Icon(Icons.ios_share,
              color: SimposiAppColors.simposiLightText),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
