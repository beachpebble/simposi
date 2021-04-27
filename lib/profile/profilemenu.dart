/*
*  profilemenu.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

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
            height: 500,
            child: ListView(
              children: [
                Divider(),
                ListTile(
                  title: Text('Edit Profile',
                  style: TextStyle(
                    color: SimposiAppColors.simposiLightText,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                  size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/editprofile');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Reset Password',
                    style: TextStyle(
                    color: SimposiAppColors.simposiLightText,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(Icons.chevron_right,
                    size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/createpassword');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/faq');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Terms of Use',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/tou');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Privacy Policy',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/privacy');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Sign Out',
                    style: TextStyle(
                      color: SimposiAppColors.simposiLightText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      size: 30
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
                Divider(),
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




