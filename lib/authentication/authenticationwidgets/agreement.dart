/*
*  agreement.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';


class Agreement extends StatelessWidget {
  final String agreementtext;

  const Agreement({
    Key? key,
    required this.agreementtext,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            Flexible(
              child: Text('I have read & understand my local regulations and the CDC Guidelines.',
                textAlign: TextAlign.start,
              ),
            ),
            AgreeButton(),

          ]
      ),
    );
  }
}
