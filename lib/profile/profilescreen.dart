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
            style: TextStyle(
              color: SimposiAppColors.simposiLightText,
              fontSize: 13,
            ),
          ),
          simposiAction: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                icon: Icon(Icons.settings_outlined,
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
            Container(
                height: 325,
                // TODO: Replace Image URL with Variable from Profile
                child: Image.asset(
                  "assets/images/profileplaceholder.png",
                  fit: BoxFit.fill,
                )),

            // Engagement Stats
            Container(
              color: Colors.white,
              height: 70,
              child: Row(children: <Widget>[
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // TODO: Turn this into a list
                      children: <Widget>[
                        // TODO: Enable Inviation Counter (Counts every invitation received regardless if it was accepted)
                        Text(
                          '10',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Invitations',
                          style: TextStyle(
                            color: SimposiAppColors.simposiLightText,
                            fontSize: 13,
                          ),
                        ),
                      ]),
                ),
                Expanded(
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
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // TODO: Enable People Counter (Counts every user from the check in screen. This user not included in Count.)
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
              ]),
            ),

            // Subscribe CTA
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Get Unlimited Access',
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 10),
                    Text(
                        'Subscribe for unlimited access and \n meet as many people as you like.'),
                    SizedBox(height: 20),

                    // TODO: Update transition to push screen up from bottom
                    SubscribeButton(
                      nextPage: '/subscribe',),
                    SizedBox(height: 20),

                    Text(
                        'Free Users will always have access \n to one social / month.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
