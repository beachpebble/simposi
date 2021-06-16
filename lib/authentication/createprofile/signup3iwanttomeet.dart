/*
*  signup3iwanttomeet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/gender.dart';

import 'cubit/registration_cubit.dart';

class SignUpForm3 extends StatefulWidget {
  @override
  _SignUpForm3State createState() => _SignUpForm3State();
}

class _SignUpForm3State extends State<SignUpForm3> {
  double progress = 0.33;

  Gender? _selected;

  void _selectGender(Gender gender) {
    setState(() {
      _selected = gender;
    });
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,

        appBar: BasicFormAppBar(),

        body: Column(
          children: [
            SizedBox(height: 45),
            Container(
              child: LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation(
                    SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
            ),

            SizedBox(height: 70),

            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: Column(
                  children: [
                    // Header Title
                    Text('I want to meet...',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),),
                    SizedBox(height: 20),

                    // TODO: Convert to Toggle Buttons
                    // Single Select Gender Buttons
                    Visibility(
                      visible: context.read<RegistrationCubit>().gender == Gender.Male,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: BigGBSelectButton(
                            buttonLabel: 'Men Only',
                            isSelected: _selected == Gender.Male,
                            buttonAction: () {
                              _selectGender(Gender.Male);
                            }),
                      ),
                    ),
                    Visibility(
                      visible: context.read<RegistrationCubit>().gender == Gender.Female,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: BigGBSelectButton(
                            buttonLabel: 'Women Only',
                            isSelected: _selected == Gender.Female,
                            buttonAction: () {
                              _selectGender(Gender.Female);
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: BigGBSelectButton(
                          buttonLabel: 'Everyone',
                          isSelected: _selected == Gender.EveryOne,
                          buttonAction: () {
                            _selectGender(Gender.EveryOne);
                          }),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selecting a gender will turn off all invitations for mixed gender events.',
                      textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(40),
              child:
              Column(
                children: [

                  // TODO: Disable Button until user has selected gender for who they want to meet
                  // TODO: Make screen resuable by changing the Continue button to a save button when user comes from profile menu?
                  BlocListener<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegistrationStage4)
                        Navigator.of(context).pushNamed('/signup4');
                    },
                    child: BigGBSelectButton(
                      buttonLabel: 'Continue',
                      buttonAction: _selected == null ? null : () =>
                      {
                        context.read<RegistrationCubit>().stage3(wantToMeet: _selected!)
                      },
                    )
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
}
