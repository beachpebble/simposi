/*
*  simposihome.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/global/theme/elements/counterbubble.dart';
import 'package:simposi_app_v4/model/event.dart';

import '../../../calendar/simposicalendar.dart';
import '../../../discover/discoverscreen.dart';
import '../../../notifications/alertsscreen.dart';
import '../../../profile/profilescreen.dart';
import '../appcolors.dart';
import 'simposinavicons.dart';

// Simposi Page Template
class SimposiHome extends StatefulWidget {
  @override
  _SimposiHomeState createState() => _SimposiHomeState();
}

class _SimposiHomeState extends State<SimposiHome> {
  // Set Home
  int simposiNavTab = 0;

  // Set Nav Bar Pages
  List<Widget> _simposiPages = [
    SimposiCalendar(),
    DiscoverScreen(),
    AlertsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: SimposiAppColors.greyBackground,

        // Call Pages (w/Header)
        body: _simposiPages[simposiNavTab],

        // Bottom Navigation Bar (Home)
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: simposiNavTab,
          onTap: (index) {
            setState(() {
              simposiNavTab = index;
            });
          },
          selectedItemColor: SimposiAppColors.simposiDarkGrey,
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: SimposiAppColors.simposiLightText,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: SimposiAppColors.simposiDarkGrey,
          ),
          items: [
            BottomNavigationBarItem(
              icon: BlocBuilder<RsvpBloc, RsvpState>(
                builder: (context, state) {
                  return Stack(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                      alignment: Alignment.center,
                      child: Icon(SimposiNav.calendar),
                    ),
                    if (state is RsvpLoaded && state.invited > 0)
                      Container(
                        child: Positioned(
                          right: 25,
                          child: SimposiCounterBubble(
                            count: state.invited.toString(),
                          ),
                        ),
                      ),
                  ]);
                },
              ),
              label: 'Socials',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    child: Icon(SimposiNav.carddeck),
                  ),

                  // Container(
                  //   child: Positioned(
                  //     right: 25,
                  //     child: SimposiCounterBubble(
                  //       count:
                  //       '134', // TODO: Enable counter for Discover Cards, hide if 0
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    child: Icon(SimposiNav.alerts),
                  ),
                  // Container(
                  //   child: Positioned(
                  //     right: 25,
                  //     child: SimposiCounterBubble(
                  //       count:
                  //       '1', // TODO: Enable counter for unread alert messages, hide if 0
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Icon(SimposiNav.profile),
              ),
              label: 'Profile',
            ),
          ],
        ),
      );
}
