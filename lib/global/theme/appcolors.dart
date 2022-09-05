/*
*  appcolors.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';

class SimposiAppColors {
  static const greyBackground = Color(0xFFF3F3F3);
  static const simposiDarkBlue = Color(0xFF1927F0);
  static const simposiFadedBlue = Color(0xFFD1D4FC);
  static const simposiLightBlue = Color(0xFF2EB9FF);
  static const simposiPink = Color(0xFFFF017E);
  static const simposiYellow = Color(0xFFFFB822);
  static const simposiDarkGrey = Color(0xFF2D2E30);
  static const simposiLightGrey = Color(0xFFE3E3E3);
  static const simposiLightText = Color(0xFF767676);
}

class LGBTQGradientMask extends StatelessWidget {
  const LGBTQGradientMask({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              SimposiAppColors.simposiLightBlue,
              Colors.yellowAccent,
              SimposiAppColors.simposiPink
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
      child: child,
    );
  }
}
