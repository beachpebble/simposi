/*
*  reportuser.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

// TODO: 1. Enable this form to Send a Message to Support,
// TODO: 2. record the user rating against the user record and
// TODO: 3. return user to Affinity Cards if more users to rate OR to HOME if this is the last user to rate.
class ReportUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: HeaderFormAppBar(
          headerTitle: 'Report User',
          popPage: '/affinityrating',
          nextButtonLabel: 'Submit ',
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Tell us what happened. If you just didn’t like this user '
                'and don’t want to see them again, go back and use the other '
                'unhappy face. This one is for reporting serious stuff only.',
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 40,
              ),
              TextField(
                maxLines: 25,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: SimposiAppColors.simposiLightText,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type here...',
                  hintStyle: TextStyle(
                    color: SimposiAppColors.simposiLightGrey,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
