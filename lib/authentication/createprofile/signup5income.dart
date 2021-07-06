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
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
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
      if (_selected.length ==
          context.read<AuthenticationBloc>().masterData.earnings.length)
        _selected.clear();
      else
        _selected.addAll(context.read<AuthenticationBloc>().masterData.earnings);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: BasicFormAppBar(),
        body:
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child:  Column(
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

                      Container(
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
                            // SizedBox(height: 20),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: context
                                  .read<AuthenticationBloc>()
                                  .masterData
                                  .earnings
                                  .length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10);
                              },
                              itemBuilder: (context, index) {
                                Earning earning = context
                                    .read<AuthenticationBloc>()
                                    .masterData
                                    .earnings[index];
                                return BigGBSelectButton(
                                    buttonLabel: earning.title,
                                    isSelected: _selected.contains(earning),
                                    buttonAction: () {
                                      _selectEarning(earning);
                                    });
                              },
                            ),
                            SizedBox(height: 10),
                            // Silent Button
                            BigGBSelectButton(
                                buttonLabel: 'Select All',
                                isSelected: _selected.length ==
                                    context
                                        .read<AuthenticationBloc>()
                                        .masterData
                                        .earnings
                                        .length,
                                buttonAction: () {
                                  _selectAll();
                                }),
                          ],
                        ),
                      ),

                      // Continue Button
                      Container(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          children: [
                            // TODO: Disable button until user has selected at least one income
                            BigGBSelectButton(
                              buttonLabel: 'Continue',
                              buttonAction: _selected.isEmpty
                                  ? null
                                  : () {
                                context
                                    .read<RegistrationCubit>()
                                    .stage5(earnings: _selected);
                                Navigator.of(context)
                                    .pushNamed('/signup6');
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })




      );
}
