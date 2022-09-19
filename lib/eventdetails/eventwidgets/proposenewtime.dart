/*
*  proposenewtime.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

class ProposeNewTime extends StatelessWidget {
  const ProposeNewTime({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BasicFormAppBar(),
        body: const Text('Propose New Time'),
      );
}
