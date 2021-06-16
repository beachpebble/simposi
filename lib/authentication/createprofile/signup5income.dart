/*
*  signup5whoearn.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/earning.dart';

class SignUpForm5 extends StatefulWidget {
  @override
  _SignUpForm5State createState() => _SignUpForm5State();
}

class _SignUpForm5State extends State<SignUpForm5> {
  double progress = 0.55;

  Set<Earning> _selected = {};

  void _selectEarning(Earning earning) {
    setState(() {
      if (_selected.contains(earning))
        _selected.remove(earning);
      else
        _selected.add(earning);
    });
  }

  void _selectAll() {
    setState(() {
      if (_selected.isEmpty)
        _selected.addAll([Earning.less35, Earning.from75to100, Earning.from35to50, Earning.from100to150, Earning.from50to75, Earning.more150]);
      else
        _selected.clear();
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
                      'Income Bracket...',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),
                    ),
                    SizedBox(height: 20),
                    // iGen Button
                    BigGBSelectButton(
                        buttonLabel: 'Less than \$35k',
                        isSelected: _selected.contains(Earning.less35),
                        buttonAction: () {
                          _selectEarning(Earning.less35);
                        }),
                    SizedBox(height: 10),
                    // Millennial Button
                    BigGBSelectButton(
                        buttonLabel: '\$35k to \$50k',
                        isSelected: _selected.contains(Earning.from35to50),
                        buttonAction: () {
                          _selectEarning(Earning.from35to50);
                        }),
                    SizedBox(height: 10),
                    // Gen X Button
                    BigGBSelectButton(
                        buttonLabel: '\$50k to \$75k',
                        isSelected: _selected.contains(Earning.from50to75),
                        buttonAction: () {
                          _selectEarning(Earning.from50to75);
                        }),
                    SizedBox(height: 10),
                    // Boomer Button
                    BigGBSelectButton(
                        buttonLabel: '\$75k to \$100k',
                        isSelected: _selected.contains(Earning.from75to100),
                        buttonAction: () {
                          _selectEarning(Earning.from75to100);
                        }),
                    SizedBox(height: 10),
                    // Silent Button
                    BigGBSelectButton(
                        buttonLabel: '\$100 to \$150k',
                        isSelected: _selected.contains(Earning.from100to150),
                        buttonAction: () {
                          _selectEarning(Earning.from100to150);
                        }),
                    SizedBox(height: 10),
                    // Silent Button
                    BigGBSelectButton(
                        buttonLabel: '\$150k +',
                        isSelected: _selected.contains(Earning.more150),
                        buttonAction: () {
                          _selectEarning(Earning.more150);
                        }),
                    SizedBox(height: 10),
                    // Silent Button
                    BigGBSelectButton(
                        buttonLabel: 'Select All',
                        buttonAction: () {
                          _selectAll();
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
                  // TODO: Disable button until user has selected at least one income
                  BlocListener<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegistrationStage6)
                        Navigator.of(context).pushNamed('/signup6', arguments: state.interests);
                    },
                    child: BigGBSelectButton(
                      buttonLabel: 'Continue',
                      buttonAction: _selected.isEmpty
                          ? null
                          : () => {
                                context
                                    .read<RegistrationCubit>()
                                    .stage5(earnings: _selected)
                              },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
}
