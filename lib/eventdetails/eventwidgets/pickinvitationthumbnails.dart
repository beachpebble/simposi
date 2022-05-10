/*
*  pickinvitationthumbnails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

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
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: SimposiAppColors.simposiLightText,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
            child: Stack(
              children: [
                // TODO: Set Image Variable to pull from DB
                // BACKGROUND IMAGE
                Center(
                  child: Image.asset(
                    "assets/images/pickinvitebackground4.png",
                    fit: BoxFit.fill,
                  ),
                ),
                // TODO: Preview button should hide until image clicked then show
                // PREVIEW OVERLAY
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    // color: Colors.black12,
                    child: SizedBox(
                      height: 30,
                      child: SmallPinkButton(
                        buttonLabel: 'Preview',
                        nextPage: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // TODO: This space should display the price of the invitation in grey text, when the image is clicked Preview button displays AND price text changes to a Blue Select button
        // TODO: Initial State - Grey Text Price displays below image thumbnail
        // TODO: Clicked State - Preview Button and Select button display (only one invited at a time)
        // TODO: Final State - On Click of Preview Button - Open Invitation as if the user was viewing and RSVP
        // TODO: Final State - On Click of Select Button - Charge users appstore account, create invite, generate receipt and all of that
        // Select Button
        Container(
          padding: EdgeInsets.only(top: 5),
          child: SizedBox(
            height: 30,
            child: SmallBlueButton(
              buttonLabel: 'Free',
              nextPage: () {},
            ),
          ),
        )
      ],
    );
  }
}
