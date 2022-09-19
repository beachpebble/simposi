/*
*  simposihome.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/global/theme/elements/counterbubble.dart';

import '../../../calendar/simposicalendar.dart';
import '../../../discover/discoverscreen.dart';
import '../../../notifications/alertsscreen.dart';
import '../../../profile/profilescreen.dart';
import '../appcolors.dart';
import 'simposinavicons.dart';

// Simposi Page Template
class SimposiHome extends StatefulWidget {
  const SimposiHome({super.key});

  @override
  State createState() => _SimposiHomeState();
}

class _SimposiHomeState extends State<SimposiHome> {
  // Set Home
  int simposiNavTab = 0;

  // Set Nav Bar Pages
  final List<Widget> _simposiPages = [
    const SimposiCalendar(),
    const DiscoverScreen(),
    AlertsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
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
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: SimposiAppColors.simposiLightText,
          ),
          selectedLabelStyle: const TextStyle(
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
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                      alignment: Alignment.center,
                      child: const Icon(SimposiNav.calendar),
                    ),
                    if (state is RsvpLoaded && state.invited > 0)
                      Positioned(
                        right: 25,
                        child: SimposiCounterBubble(
                          count: state.invited.toString(),
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    child: const Icon(SimposiNav.carddeck),
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    child: const Icon(SimposiNav.alerts),
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
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: const Icon(SimposiNav.profile),
              ),
              label: 'Profile',
            ),
          ],
        ),
      );
}
