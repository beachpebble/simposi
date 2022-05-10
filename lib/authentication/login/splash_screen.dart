import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO design page as startuplogo
    return Scaffold(
      backgroundColor: SimposiAppColors.simposiDarkBlue,
      body: Center(
          child: SizedBox(
              child: CircularProgressIndicator(
                color: SimposiAppColors.simposiPink,
              ),
              width: 48.0,
              height: 48.0)),
    );
  }
}
