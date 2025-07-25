/*
*  whoami_menu.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/profile/elements/simposimenucard.dart';


class InvitationSettings extends StatefulWidget {
  const InvitationSettings({Key? key}) : super(key: key);

  @override
  _InvitationSettingsState createState() => _InvitationSettingsState();
}

class _InvitationSettingsState extends State<InvitationSettings> {
  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,

      appBar: BasicFormAppBar(),

      body: Column(
        children: [
          // Menu List
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    SimposiMenuCard(
                      menuCardIcon: Icon(Icons.perm_identity,
                        color: SimposiAppColors.simposiPink,
                      ),
                      menuCardLabel: 'I Identify as...',
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup2edit');
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: Icon(Icons.cake_outlined,
                        color: SimposiAppColors.simposiLightBlue,
                        size: 20,
                      ),
                      menuCardLabel: 'My Generations...',
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup3'); // TODO: Enable Edit mode like Signup2 above
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: Icon(Icons.work_outline,
                        color: SimposiAppColors.simposiYellow,
                      ),
                      menuCardLabel: 'My Income Range...',
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup4'); // TODO: Enable Edit mode like Signup2 above
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: Icon(Icons.directions_bike,
                        color: SimposiAppColors.simposiPink,
                      ),
                      menuCardLabel: 'Activities I like...',
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup5activities'); // TODO: Enable Edit mode like Signup2 above
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: Icon(Icons.location_searching,
                        color: SimposiAppColors.simposiLightBlue,
                      ),
                      menuCardLabel: 'Location & Distance...',
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup6'); // TODO: Enable Edit mode like Signup2 above
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/logosquare.png'),
                ),
                SizedBox(height: 5),
                Text('Version 4.1.0',
                  style: TextStyle(
                    fontSize: 13,
                    color: SimposiAppColors.simposiLightText,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

    ),
  );

}