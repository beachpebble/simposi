/*
*  profilescreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import '../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          // TODO: Insert username and city variables
          simposiTitle: 'Flora',
          simposiSubTitle: Text('Vancouver',
            style: const TextStyle(
              color: SimposiAppColors.simposiLightText,
              fontSize: 13,
            ),
          ),
          simposiAction: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                icon: const Icon(Icons.settings_outlined,
                color: SimposiAppColors.simposiLightText,
                size: 30),
                onPressed: () => {
                  Navigator.of(context).pushNamed('/profilemenu'),
                }),
          ),
          ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Image
            Expanded(
              child: Container(
                  // TODO: Replace Image URL with Variable from Profile
                  child: Image.asset(
                    "assets/images/profileplaceholder.png",
                    fit: BoxFit.cover,
                  )),
            ),

            // Engagement Stats
            Container(
              color: Colors.white,
              height: 70,
              child: Row(
                  children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // TODO: Turn these into a ListTile's
                          // TODO: Enable Profile Counters
                          children: <Widget>[
                            // TODO: Enable Invitation Counter (Counts every RSVP received regardless if it was accepted)
                            Text( '10',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text( 'Invitations',
                              style: const TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 13,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // TODO: Enable Check In Counter (Counts everytime user checked in for an event)
                            Text(
                              '10',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Event Attended',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 13,
                              ),
                            ),
                          ]),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // TODO: Enable People Counter (Counts every affinity survey sent.)
                            Text(
                              '10',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'People Met',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 13,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
              ),

              // Subscribe Footer Area
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text('Get Unlimited Access',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 10),
                    Text(
                        'Subscribe for unlimited access and \n meet as many people as you like.',
                    style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(height: 10),
                    // TODO: Update transition to draw bottom sheet instead of screen
                    SubscribeButton(
                      nextPage: '/subscribe',),
                    SizedBox(height: 10),
                    Text(
                        'Free Users will always be able to \ncreate or attend one meetup per month.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
          ],
        ),
      );
}
