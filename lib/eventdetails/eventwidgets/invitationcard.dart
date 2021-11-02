/*
*  invitationcard.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/datetimepicker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import '../../app_router.dart';

class InvitationCard extends StatelessWidget {

  final EventModel eventModel;

  const InvitationCard({Key? key, required this.eventModel}) : super(key: key);

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
              )),
        ),

        // INVITATION DETAILS
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 300),
                const Text('You\'ve been invited to'),
                const SizedBox(height: 10),
                Text(
                  eventModel.rsvp.event.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                 eventModel.addressRepresentaion,
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

                    // TODO: Enable RSVP Button to show confirmation dialogue, update status on RSVP to accepted when user clicks
                    // RSVP BUTTON
                    BigGBSelectButton(
                      buttonLabel: 'RSVP ${DateFormat('MMM dd, yyyy').format(eventModel.rsvp.fullDate)}',
                      buttonAction: () => {
                        Navigator.of(context).restorablePush(_dialogBuilder),
                      },
                      // TODO: Trigger RSVP Actions AND popup confirm RSVP AND redirect back to Calendar
                    ),
                    const SizedBox(height: 10),

                    // TODO: Enabled Propose New Time Button
                    // PROPOSE NEW TIME BUTTON
                    BigGBSelectButton(
                      buttonLabel: 'Propose New Time',
                      buttonAction: () => showSheet(
                        context,
                        // TODO: Enable this to set the variable and write it into the form field
                        onClicked: () =>
                            {Navigator.of(context).pushNamed('/eventdetails')},
                        child: Container(
                            height: 300, child: SimposiDateTimePicker()),
                      ),
                    ),

                    // DECLINE BUTTON
                    const SizedBox(height: 10),
                    TextButton(
                      // TODO: Set status on RSVP to decline so that the RSVP no longer appears on the calendar
                      onPressed: () =>
                          {AutoRouter.of(context).replace(SimposiHomeRoute())},
                      // TODO: Enable Decline button to set RSVP status to declined which should remove the RSVP from the users calendar and updates counts etc.
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                        ),
                      ),
                      style: const ButtonStyle(),
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
                    color: SimposiAppColors.simposiLightText),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      );

  // DIALOGUE
  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('You\'re Going!'),
          content: Text('Ditch Fashion Show \n Sept. 16, 2021'),
          actions: <Widget>[
            CupertinoDialogAction(
                // TODO: Enable click to open a bottom sheet which list share options, like copy url, SMS, email, whatsapp, messenger, etc.
                child: Text('Invite a Friend'),
                onPressed: () {}),
            CupertinoDialogAction(
              child: Text('Done'),
              onPressed: () => AutoRouter.of(context).push(SimposiHomeRoute()),
            ),
          ],
        );
      },
    );
  }

  // Share Bottomsheet
  static _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;
  }

  // Date Time Picker Action Sheet
  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: const Text(
            'Propose New Time',
            style: TextStyle(
              fontSize: 17,
              color: SimposiAppColors.simposiDarkGrey,
            ),
          ),
          message: const Text(
            'If the organizer accepts \nyour RSVP will be automatic.',
            style: TextStyle(
              fontSize: 15,
              color: SimposiAppColors.simposiLightText,
            ),
          ),
          actions: [
            child,
          ],
          // TODO: Capture Date/Time from picker, generate Alert message for user who created the event
          cancelButton: CupertinoActionSheetAction(
            child: Text('Submit'),
            onPressed: onClicked,
          ),
        ),
      );
}
