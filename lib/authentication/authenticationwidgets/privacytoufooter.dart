/*
*  privacytoufooter.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

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
          nextPage: () => AutoRouter.of(context).push(const PrivacyScreenRoute()),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
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
          nextPage: ()=> AutoRouter.of(context)
              .push(const TermsOfUseRoute()),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
