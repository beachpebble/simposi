/*
*  dialoguewidget.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SimposiDialogue {

  static void showSheet(
      BuildContext context, {
        required Widget child,
        required VoidCallback onClicked,
      }) =>
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoActionSheet(
              actions: [
                child,
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text('Save'),
                onPressed: onClicked,
              ),
            )
        );

}