/*
*  signup8validate.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:simposi_app_v4/authentication/authenticationwidgets/pincodefields.dart';
import '../../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


class SignUpForm8 extends StatelessWidget {


  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,

      appBar: BasicFormAppBar(),

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // HEADER
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset("assets/images/logo.png"),
                          Text(
                            'simposi',
                            style: TextStyle(
                              color: SimposiAppColors.simposiDarkBlue,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FORM
                    Container(
                      child: Column(
                        children: [
                          // TITLE
                          Text('Account Created',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              color: SimposiAppColors.simposiDarkGrey,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text('Check your email for an access code \n to activate your account.',
                            textAlign: TextAlign.center,),
                          SizedBox(height: 25),

                          // TODO: Enable These
                          // PIN CODE FIELDS
//                          PinCodeFields(),

                          SizedBox(height: 25),
                          BigGBSelectButton(
                            buttonLabel: 'Verify',
                            buttonAction: () =>
                            {
                              Navigator.of(context).pushReplacementNamed('/home'),
                            },
                          ),
                          SizedBox(height: 15),
                          SimposiTextButton(
                            buttonLabel: 'I never received a code',
                            nextPage: '/home',
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),

                          SizedBox(height: 10),

                          // TODO: Enable Resend Code Timer
                          Text('Resend in 3s',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: [
                          Text(
                            '© 2021 Simposi Inc.',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    ),
  );
}
