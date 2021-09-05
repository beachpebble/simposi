/*
*  checkinbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';


// TODO: Trigger Check In Bottom Sheet from Check In Notification (Banner/Lockscreen) - so they land on Socials with Bottom Sheet open
// BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class CheckInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: SimposiAppColors.simposiPink,
        shape: StadiumBorder(),
      ),

      // TODO: Enable Check In Button
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return CheckInPopup();
          },
        );
      },
      
      child: Text(
        "Check In",
        textAlign: TextAlign.center,
      ),
    );
    
  }
}


// CHECK IN BOTTOM SHEET
class CheckInPopup extends StatefulWidget {
  @override
  _CheckInPopupState createState() => _CheckInPopupState();
}

class _CheckInPopupState extends State<CheckInPopup> {

  @override
  Widget build(BuildContext context) => Container(
    // Transparent Overlay
    color: Colors.black54,
    // Bottom Sheet
    child: Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
      child: Column(
        children: [
          Text('First to Arrive',
          style: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontWeight: FontWeight.w900,
            fontSize: 19,
            ),
          ),
          SizedBox(height: 10),
          Text('Ditch Fashion Show',
            style: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),),
          SizedBox(height: 10),
          Text('First to arrive picks the meeting spot.'),
          SizedBox(height: 10),
          Text('Find a good location to wait and then use \nthe button below to set the meeting \nlocation and check in.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.asset("assets/images/airbaloon.png"),
          SizedBox(height: 20),

          // BUTTONS
          BigCheckInButton(),
          SizedBox(height: 10),
          BigButton(
            buttonLabel: 'Cancel RSVP',
            buttonAction: null,
            buttonColor: SimposiAppColors.simposiLightGrey,
            textColor: SimposiAppColors.simposiDarkGrey,
          ),

        ],
      ),

    ),
  );
}


