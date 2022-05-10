/*
*  getstartedscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import '../authenticationwidgets/privacytoufooter.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: SimposiAppColors.simposiDarkBlue,
        body: Container(
          decoration: const BoxDecoration(
            image: const DecorationImage(
                image: const AssetImage("assets/images/background.png"),
                fit: BoxFit.contain,
                alignment: Alignment.topLeft),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LOGIN FORWARD BUTTON
                Container(
                    height: 100,
                    padding: const EdgeInsets.only(top: 40),
                    child: LoginForwardTextButton(
                      onClick: () =>
                          AutoRouter.of(context).push(LoginScreenRoute()),
                    )),

                // BODY
                Container(
                  height: 350,
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'simposi',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Muli',
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/logo.png")
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'A new way to match and meet \npeople with the same interests.',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          GetStartedButton(
                              onClick: () => AutoRouter.of(context)
                                  .push(SignUpForm1Route())),
                        ],
                      ),
                    ],
                  ),
                ),

                // FOOTER
                Container(
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: const PrivacyTOUFooter(
                    footerColor: Colors.white,
                  ),
                ),
              ]),
        ),
      );
}
