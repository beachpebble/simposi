/*
*  pickinvitationthumbnails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/calendar/calendarwidgets/checkinbottomsheet.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

// TODO: Create a Test list to iterate over?
// TODO: Create & Insert Variables for Invitation Thumbnails
// TODO: Enable First Click to Display Overlay with Preview and Select Buttons
// TODO: Enable Preview and Select Buttons
// TODO: Create Event when Select chosen, attached selected invitation to event, and charge users app store account based on price of selected invite
class PickInvitationThumbnail extends StatelessWidget {
  const PickInvitationThumbnail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: SimposiAppColors.simposiLightText,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Container(
            child: InkWell(
              onTap: () => {
                Navigator.of(context).pushNamed('/home'),
              },
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      // BACKGROUND IMAGE
                      Container(
                        child: Image.asset("assets/images/pickinvitebackground2.png",
                        fit: BoxFit.cover,
                        ),
                      ),

                      // Preview Overlay
                     Center(
                       child: Container(
                         padding: EdgeInsets.all(20),
                          // color: Colors.black12,
                         child: SmallPinkButton(
                           buttonLabel: 'Preview',
                           nextPage: () {},
                         ),
                        ),
                     ),

                    ],
                  ),
                  Container(
                    child: TinyTextButton(
                      buttonLabel: 'Free',
                      color: SimposiAppColors.simposiLightText,
                      footerButtonAlign: TextAlign.center,
                      nextPage: '/home',
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ],
    );
  }
}

