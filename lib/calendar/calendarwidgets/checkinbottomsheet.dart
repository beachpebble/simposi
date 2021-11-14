/*
*  checkinbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbars.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/model/rsvp.dart';

import '../../app_router.dart';


// BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class CheckInButton extends StatelessWidget {
  final Rsvp rsvp;

  const CheckInButton({Key? key, required this.rsvp}) : super(key: key);
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
            return CheckInPopup(rsvp: rsvp);
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
  final Rsvp rsvp;

  const CheckInPopup({Key? key, required this.rsvp}) : super(key: key);
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
          BigCheckInButton(onClick: () => AutoRouter.of(context).push(GroupFinderRoute())),
          SizedBox(height: 10),
          BigButton(
            buttonLabel: 'Cancel RSVP',
            buttonAction: (){
              AutoRouter.of(context)
                  .pushNativeRoute(dialogBuilder(context, widget.rsvp, false));
            },
            buttonColor: SimposiAppColors.simposiLightGrey,
            textColor: SimposiAppColors.simposiDarkGrey,
          ),

        ],
      ),

    ),
  );
}


