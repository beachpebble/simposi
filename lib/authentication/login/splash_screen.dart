import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO design page as startuplogo
    return const Scaffold(
      backgroundColor: SimposiAppColors.simposiDarkBlue,
      body: Center(
          child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: CircularProgressIndicator(
                color: SimposiAppColors.simposiPink,
              ))),
    );
  }
}
