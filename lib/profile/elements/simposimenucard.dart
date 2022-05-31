/*
*  simposimenucard.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SimposiMenuCard extends StatelessWidget {
  final Icon menuCardIcon;
  final String menuCardLabel;
  final VoidCallback onTap;

  const SimposiMenuCard({
    super.key,
    required this.menuCardIcon,
    required this.menuCardLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: SimposiAppColors.simposiLightGrey,
        ),
      ),
      child: ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            menuCardLabel,
            style: const TextStyle(
              color: SimposiAppColors.simposiLightText,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: SizedBox(
          width: 20,
          child: menuCardIcon,
        ),
        trailing: const Icon(Icons.chevron_right, size: 30),
        onTap: onTap,
      ),
    );
  }
}

class SimposiMenuCardx extends StatelessWidget {
  const SimposiMenuCardx({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: SimposiAppColors.simposiLightGrey,
        ),
      ),
      child: ListTile(
        title: const Align(
          alignment: Alignment(-1.2, 0),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: SimposiAppColors.simposiLightText,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: const Icon(
          Icons.person_outline,
          color: SimposiAppColors.simposiPink,
        ),
        trailing: const Icon(Icons.chevron_right, size: 30),
        onTap: () {
          Navigator.of(context).pushNamed('/editprofile');
        },
      ),
    );
  }
}
