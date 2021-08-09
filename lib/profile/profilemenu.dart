/*
*  profilemenu.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'elements/simposimenucard.dart';

class ProfileMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) => Scaffold(
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
                      menuCardIcon: Icon(Icons.person_outline,
                        color: SimposiAppColors.simposiLightBlue,
                      ),
                      menuCardLabel: 'Account Settings',
                      onTap: () {
                        Navigator.of(context).pushNamed('/editprofile');
                      },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.vpn_key_outlined,
                      color: SimposiAppColors.simposiPink,
                    ),
                    menuCardLabel: 'Change Password',
                    onTap: () {
                      Navigator.of(context).pushNamed('/changePassword');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.markunread_mailbox_outlined,
                      color: SimposiAppColors.simposiYellow,
                      size: 20,
                    ),
                    menuCardLabel: 'Who am I',
                    onTap: () {
                      Navigator.of(context).pushNamed('/invitationsettings');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.perm_contact_calendar_outlined,
                      color: SimposiAppColors.simposiLightBlue,
                      size: 20,
                    ),
                    menuCardLabel: 'Who I want to Meet',
                    onTap: () {
                      Navigator.of(context).pushNamed('/eventsettings');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.local_hospital_outlined,
                      color: SimposiAppColors.simposiPink,
                    ),
                    menuCardLabel: 'Emergency Contact',
                    onTap: () {
                      Navigator.of(context).pushNamed('/emergencycontact');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.help_outline_outlined,
                      color: SimposiAppColors.simposiYellow,
                    ),
                    menuCardLabel: 'FAQ      ',
                    onTap: () {
                      Navigator.of(context).pushNamed('/faq');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.sticky_note_2_outlined,
                      color: SimposiAppColors.simposiLightBlue,
                    ),
                    menuCardLabel: 'Terms of Use',
                    onTap: () {
                      Navigator.of(context).pushNamed('/tou');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.privacy_tip_outlined,
                      color: SimposiAppColors.simposiPink,
                    ),
                    menuCardLabel: 'Privacy Policy',
                    onTap: () {
                      Navigator.of(context).pushNamed('/privacy');
                    },
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.question_answer_outlined,
                      color: SimposiAppColors.simposiYellow,
                    ),
                    menuCardLabel: 'Support',
                    onTap: () {},
                  ),
                  SimposiMenuCard(
                    menuCardIcon: Icon(Icons.exit_to_app,
                      color: SimposiAppColors.simposiLightBlue,
                    ),
                    menuCardLabel: 'Sign Out',
                    onTap: () {
                      context.read<AuthenticationBloc>().add(LogOut());
                    },
                  ),
                ]
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
  );
}






