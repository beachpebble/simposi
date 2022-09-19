/*
*  sharemydetailsbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/social_icons.dart';

// TODO: Trigger Check In Bottom Sheet from Check In Notification (Banner/Lockscreen) - so they land on Socials with Bottom Sheet open
// BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class ShareDetailsButton extends StatelessWidget {
  const ShareDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: SimposiAppColors.simposiDarkGrey,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
        ),

        // TODO: Enable Check In Button
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const ShareDetailsPopup();
            },
          );
        },

        child: const Text(
          "Share my Details",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// SHARE DETAILS BOTTOM SHEET
class ShareDetailsPopup extends StatefulWidget {
  const ShareDetailsPopup({super.key});

  @override
  State createState() => _ShareDetailsPopupState();
}

class _ShareDetailsPopupState extends State<ShareDetailsPopup> {
  final Color _facebook = SimposiAppColors.simposiLightText;
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
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: Column(
              children: [
                const Text(
                  'Making Friends!',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'The next step is sending them a message. \nHow would you like to chat?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        // TODO: Enable button color change on selected
                        child: IconButton(
                            icon: Icon(
                              Social.facebook_square,
                              color: _facebook,
                              size: 50,
                            ),
                            onPressed: () {
                              if (_facebook ==
                                  SimposiAppColors.simposiLightText) {
                                _facebook == SimposiAppColors.simposiDarkBlue;
                              } else {
                                _facebook == SimposiAppColors.simposiLightText;
                              }
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(
                              Social.instagram,
                              color: SimposiAppColors.simposiLightText,
                              size: 50,
                            ),
                            onPressed: () {}),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(
                              Social.linkedin,
                              color: SimposiAppColors.simposiLightText,
                              size: 50,
                            ),
                            onPressed: () {}),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: const Icon(
                              Social.mail,
                              color: SimposiAppColors.simposiLightText,
                              size: 50,
                            ),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Message:', textAlign: TextAlign.left),
                  ],
                ),
                const TextField(
                  maxLines: 4,
                  maxLength: 220,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'Flora has shared contact info. Send a message and keep the conversation going.',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // TODO: Enable button only when user has selected an Icon Button, change color to Blue when enabled, capture message and send message to the other user
                // Button
                const BigButton(
                  buttonLabel: 'Share my Details',
                  buttonAction: null,
                  buttonColor: SimposiAppColors.simposiLightGrey,
                  textColor: SimposiAppColors.simposiDarkGrey,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add contact methods to your profile to see it here.',
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
