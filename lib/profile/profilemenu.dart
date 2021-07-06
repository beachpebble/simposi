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

class ProfileMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,

    appBar: BasicFormAppBar(),

    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox (
            height: 600,
            child: ListView(
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Edit Profile',
                      style: TextStyle(
                        color: SimposiAppColors.simposiLightText,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.person_outline,
                      color: SimposiAppColors.simposiPink,
                    ),
                    trailing: Icon(Icons.chevron_right,
                    size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/editprofile');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Change Password',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.vpn_key_outlined,
                      color: SimposiAppColors.simposiYellow,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/changePassword');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Invitation Settings',
                        style: TextStyle(
                        color: SimposiAppColors.simposiLightText,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                  ),
                    ),
                    leading: Icon(Icons.markunread_mailbox_outlined,
                      color: SimposiAppColors.simposiLightBlue,
                      size: 20,
                    ),
                  trailing: Icon(Icons.chevron_right,
                      size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/invitationsettings');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Emergency Contact',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.local_hospital_outlined,
                      color: SimposiAppColors.simposiPink,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/emergencycontact');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.1, 0),
                      child: Text('FAQ      ',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.help_outline_outlined,
                      color: SimposiAppColors.simposiYellow,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/faq');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Terms of Use',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.sticky_note_2_outlined,
                      color: SimposiAppColors.simposiLightBlue,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/tou');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Privacy Policy',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.privacy_tip_outlined,
                      color: SimposiAppColors.simposiPink,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/privacy');
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Support',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.question_answer_outlined,
                      color: SimposiAppColors.simposiYellow,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: SimposiAppColors.simposiLightGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment(-1.2, 0),
                      child: Text('Sign Out',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    leading: Icon(Icons.exit_to_app,
                      color: SimposiAppColors.simposiLightBlue,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        size: 30
                    ),
                    onTap: () {
                      context.read<AuthenticationBloc>().add(LogOut());
                    },
                  ),
                ),
              ]
            ),
          ),
        ),

          Expanded(
            child: Container(
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
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
    ),
  );
}




