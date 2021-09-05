/*
*  privacytoufooter.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/profile/termsofuse.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import '../../global/widgets/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import '../../global/widgets/simposiicons.dart';



class PrivacyTOUFooter extends StatelessWidget {
  final Color footerColor;

  const PrivacyTOUFooter({Key? key, required this.footerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TinyTextButton(
          color: footerColor,
          buttonLabel: 'Privacy',
          footerButtonAlign: TextAlign.right,
          nextPage: '/privacy',
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
          child: Icon(
            Icons.circle,
            color: footerColor,
            size: 5,
          ),
        ),
        TinyTextButton(
          color: footerColor,
          buttonLabel: 'Terms of Use',
          footerButtonAlign: TextAlign.left,
          nextPage: '/termsofuse',
        ),
        SizedBox(width: 15),
      ],
    );
  }
}

