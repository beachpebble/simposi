/*
*  invitationsettings.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
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
                            child: Text('I Identify as...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.perm_identity,
                            color: SimposiAppColors.simposiPink,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup2edit'),
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
                            child: Text('I want to meet...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.people_outline,
                            color: SimposiAppColors.simposiYellow,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup3'),
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
                            child: Text('Who are...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.cake_outlined,
                            color: SimposiAppColors.simposiLightBlue,
                            size: 20,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup4'),
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
                            child: Text('Who earn...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.work_outline,
                            color: SimposiAppColors.simposiPink,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup5'),
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
                            child: Text('Who like to...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.directions_bike,
                            color: SimposiAppColors.simposiYellow,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup6'),
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
                            child: Text('Who are nearby...',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          leading: Icon(Icons.location_searching,
                            color: SimposiAppColors.simposiLightBlue,
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => {
                            Navigator.of(context).pushNamed('/signup7'),
                          },
                        ),
                      ),
                    ],
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

    ),
  );

}
