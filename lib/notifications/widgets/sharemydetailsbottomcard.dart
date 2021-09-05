/*
*  sharemydetailsbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/widgets/social_icons.dart';


// TODO: Trigger Check In Bottom Sheet from Check In Notification (Banner/Lockscreen) - so they land on Socials with Bottom Sheet open
// BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class ShareDetailsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: SimposiAppColors.simposiDarkGrey,
          shape: StadiumBorder(),
          padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
        ),

        // TODO: Enable Check In Button
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ShareDetailsPopup();
            },
          );
        },

        child: Text(
          "Share my Details",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


// SHARE DETAILS BOTTOM SHEET
class ShareDetailsPopup extends StatefulWidget {


  @override
  _ShareDetailsPopupState createState() => _ShareDetailsPopupState();
}

class _ShareDetailsPopupState extends State<ShareDetailsPopup> {
  Color _facebook = SimposiAppColors.simposiLightText;
  final Color _instagram = SimposiAppColors.simposiLightText;
  final Color _linkedin = SimposiAppColors.simposiLightText;
  final Color _email = SimposiAppColors.simposiLightText;

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Container(
      height: 600,
      // Transparent Overlay
      color: Colors.black87,
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
            Text('Making Friends!',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: SimposiAppColors.simposiDarkGrey,
            ),),
            SizedBox(height: 10),
            Text('The next step is sending them a message. \nHow would you like to chat?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    // TODO: Enable button color change on selected
                    child: IconButton(
                        icon: Icon(Social.facebook_square,
                          color: _facebook,
                          size: 50,
                        ),
                        onPressed: () {
                          if(_facebook == SimposiAppColors.simposiLightText) {
                            _facebook == SimposiAppColors.simposiDarkBlue;
                          } else {
                            _facebook == SimposiAppColors.simposiLightText;
                          }
                        }
                        ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(Social.instagram,
                          color: SimposiAppColors.simposiLightText,
                          size: 50,
                        ),
                        onPressed: () {
                        }
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(Social.linkedin,
                          color: SimposiAppColors.simposiLightText,
                          size: 50,
                        ),
                        onPressed: () {}
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(Social.mail,
                          color: SimposiAppColors.simposiLightText,
                          size: 50,
                        ),
                        onPressed: () {}
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Message:',
                textAlign: TextAlign.left),
              ],
            ),
            TextField(
              maxLines: 4,
              maxLength: 220,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Flora has shared contact info. Send a message and keep the conversation going.',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 40),

            // TODO: Enable button only when user has selected an Icon Button, change color to Blue when enabled, capture message and send message to the other user
            // Button
            BigButton(
                buttonLabel: 'Share my Details',
                buttonAction: null,
                buttonColor: SimposiAppColors.simposiLightGrey,
                textColor: SimposiAppColors.simposiDarkGrey,
            ),
            SizedBox(height: 20),
            Text('Add contact methods to your profile to see it here.',
              style: TextStyle(
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),

      ),
    ),
  );
}


