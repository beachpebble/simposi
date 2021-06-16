/*
*  signup4generation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/generation.dart';

import 'cubit/registration_cubit.dart';

class SignUpForm4 extends StatefulWidget {
  @override
  _SignUpForm4State createState() => _SignUpForm4State();
}

class _SignUpForm4State extends State<SignUpForm4> {
  Set<Generation> _selected = {};
  double progress = 0.44;

  void _selectGeneration(Generation gender) {
    setState(() {
      if (_selected.contains(gender))
        _selected.remove(gender);
      else
        _selected.add(gender);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: BasicFormAppBar(),
        body: Column(
          children: [
            SizedBox(height: 45),
            Container(
              child: LinearProgressIndicator(
                value: progress,
                valueColor:
                    AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
            ),

            SizedBox(height: 70),

            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: Column(
                  children: [
                    // Header
                    Text(
                      'Generation...',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),
                    ),
                    SizedBox(height: 20),
                    // iGen Button
                    BigGBSelectButton(
                        buttonLabel: 'iGen (1996 - Present)',
                        isSelected: _selected.contains(Generation.IGen),
                        buttonAction: () {
                          _selectGeneration(Generation.IGen);
                        }),
                    SizedBox(height: 10),
                    // Millennial Button
                    BigGBSelectButton(
                        buttonLabel: 'Millennial (1981 - 1995)',
                        isSelected: _selected.contains(Generation.Millenial),
                        buttonAction: () {
                          _selectGeneration(Generation.Millenial);
                        }),
                    SizedBox(height: 10),
                    // Gen X Button
                    BigGBSelectButton(
                        buttonLabel: 'Gen X (1965 - 1980)',
                        isSelected: _selected.contains(Generation.GenX),
                        buttonAction: () {
                          _selectGeneration(Generation.GenX);
                        }),
                    SizedBox(height: 10),
                    // Boomer Button
                    BigGBSelectButton(
                        buttonLabel: 'Boomer (1946 - 1964)',
                        isSelected: _selected.contains(Generation.Boomer),
                        buttonAction: () {
                          _selectGeneration(Generation.Boomer);
                        }),
                    SizedBox(height: 10),
                    // Silent Button
                    BigGBSelectButton(
                        buttonLabel: 'Silent (1928 - 1945)',
                        isSelected: _selected.contains(Generation.Silent),
                        buttonAction: () {
                          _selectGeneration(Generation.Silent);
                        }),
                  ],
                ),
              ),
            ),

            // Continue Button
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  BlocListener<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegistrationStage5)
                        Navigator.of(context).pushNamed('/signup5');
                    },
                    child: BigGBSelectButton(
                      buttonLabel: 'Continue',
                      buttonAction: _selected.isNotEmpty ? () => {
                        context.read<RegistrationCubit>().stage4(generations: _selected)
                      } : null,
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
