/*
*  simposihome.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../appcolors.dart';
import 'simposiappbar.dart';
import 'simposinavicons.dart';
import '../../../calendar/simposicalendar.dart';
import '../../../discover/discoverscreen.dart';
import '../../../notifications/alertsscreen.dart';
import '../../../profile/profilescreen.dart';

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
              icon: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Icon(SimposiNav.calendar),
              ),
              label: 'Socials',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Icon(SimposiNav.carddeck),
              ),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Icon(SimposiNav.alerts),
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
