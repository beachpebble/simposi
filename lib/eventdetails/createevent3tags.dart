/*
*  createevent3tags.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/widgets/searchbar.dart';

// TODO: DEPRECATED UI. PLEASE ENABLE FUNCTIONALITY ON FOLDER UI AND DELETE THIS ONE. THIS IS JUST FOR CLICK PATH.
// TODO: This is an old layout. Please replace this screen with the layout from authentication and update for the create event process.
class CreateEvent3 extends StatefulWidget {

  @override
  _CreateEvent3State createState() => _CreateEvent3State();
}

class _CreateEvent3State extends State<CreateEvent3> {
  // Set Variables
  double progress = 0.42;

  // TODO: Pass backend activities to this list
  final List<Activity> allActivities = <Activity>[
    const Activity('Bowling'),
    const Activity('Arts & Crafts'),
    const Activity('Watersports'),
    const Activity('Tennis'),
    const Activity('Watersports'),
    const Activity('Tennis'),
    const Activity('Bowling'),
    const Activity('Swimming'),
    const Activity('Watersports'),
    const Activity('Football'),
    const Activity('Soccer'),
    const Activity('Hockey'),
  ];
  List<String> _filters = <String>[];

  // FOR EACH ACTIVITY CREATE AN ACTIVITY BUTTON
  Iterable<Widget> get selectedActivityWidgets sync* {
    for (final Activity selectedActivity in allActivities) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: InputChip(
          label: Text(selectedActivity.label),
          elevation: 0,
          showCheckmark: false,
          selectedColor: SimposiAppColors.simposiDarkBlue,
          selected: _filters.contains(selectedActivity.label),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(selectedActivity.label);
              } else {
                _filters.removeWhere((String label) {
                  return label == selectedActivity.label;
                });
              }
            });
          },
        ),
      );
    }
  }

  // CREATE EVENT 3 LAYOUT
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,

        appBar: CancelFormAppBar(),

        body: Column(
          children: [
            SizedBox(height: 45),
            Container(
              child: LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
            ),

            SizedBox(height: 70),

            Expanded(
              child: Container(
                child: Column(
                  children: [

                    // Header
                    Text('What kind of activity is this?',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),),
                    SizedBox(height: 20),
                    Text('Choose as many interests as you like.',
                      style: TextStyle(
                        color: SimposiAppColors.simposiLightText,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 20),

                    // TODO: Implement a Search/Filter Bar for Activities
                    Container(

                    ),


                    // TAG CLOUD
                    Container(
                      child:
                        Wrap(
                          runSpacing: -8.0,
                          children: selectedActivityWidgets.toList(),
                        ),
                    ),

                  ],
                ),
              ),
            ),

            // Continue Button
            Container(
              padding: EdgeInsets.all(40),
              child:
              Column(
                children: [

                  // TODO: Disable button until user has selected at least one activity
                  // TODO: IF user has settings saved for I want to meet, skip to Who are, IF user has settings from Who Are, skip to Who earn, If user has settings for who earn, skip to pick invitation...
                  BigGBSelectButton(
                    buttonLabel: 'Continue',
                    buttonAction: () =>
                    {
                      Navigator.of(context).pushNamed('/createevent4'),
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );

}

// VARIABLE FOR EACH ACTIVITY
class Activity {
  const Activity(this.label);
  final String label;
}