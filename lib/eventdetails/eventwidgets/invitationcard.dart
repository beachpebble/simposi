/*
*  invitationcard.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

class InvitationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: new ExactAssetImage('assets/images/invitationcard.png'),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.white70,
            BlendMode.lighten,
          )
      ),
    ),

    // INVITATION DETAILS
    child: Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 300),
            const Text('You\'ve been invited to'),
            const SizedBox(height: 10),
            // TODO: Replace with Variable
            // Event Title
            Text('Ditch Fashion Show',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: SimposiAppColors.simposiDarkGrey,
              ),
            ),
            const SizedBox(height: 10),
            // TODO: Replace with Location with Variable
            // Event Location
            Text('123 Main Street, Vancouver, BC',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: SimposiAppColors.simposiDarkGrey,
              ),
            ),
          ],
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 50),

                // TODO: Enable RSVP Button to show confirmation dialogue
                // RSVP BUTTON
                BigGBSelectButton(
                  buttonLabel: 'RSVP Jun 5, 2021',
                  buttonAction: () => {
                    Navigator.of(context).pushNamed('/home'),
                  },
                  // TODO: Trigger RSVP Actions AND popup confirm RSVP AND redirect back to Calendar
                ),
                const SizedBox(height: 10),

                // TODO: Enabled Propose New Time Button
                // PROPOSE NEW TIME BUTTON
                BigGBSelectButton(
                  buttonLabel: 'Propose New Time',
                  buttonAction: () => {
                    Navigator.of(context).pushNamed('/proposenewtime'),
                  },
                ),

                // DECLINE BUTTON
                const SizedBox(height: 10),
                TextButton(
                  // TODO: Set status on RSVP to decline so that the RSVP no longer appears on the calendar
                  onPressed: () => {
                    Navigator.of(context).pushReplacementNamed('/home'),
                  },
                  child: const Text('Decline',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                    ),
                  ),
                  style: const ButtonStyle(

                  ),
                ),
              ],
            ),
          ),
        ),

        Column(
          children: [
            const Text('Scroll for Details'),
            const SizedBox(height: 10),
            const Icon(Icons.arrow_circle_down_rounded,
                color: SimposiAppColors.simposiLightText
            ),
            const SizedBox(height: 30),

          ],
        ),
      ],
    ),
  );
}
