/*
*  signup4generation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
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
    context.read<RegistrationCubit>().stage4(generations: _selected);
  }

  @override
  void initState() {
    super.initState();
    _selected = context.read<RegistrationCubit>().generations ?? {};
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
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: context
                          .read<AuthenticationBloc>()
                          .masterData
                          .generations
                          .length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return BigGBSelectButton(
                            buttonLabel: context
                                .read<AuthenticationBloc>()
                                .masterData
                                .generations[index]
                                .title,
                            isSelected: _selected.contains(context
                                .read<AuthenticationBloc>()
                                .masterData
                                .generations[index]),
                            buttonAction: () {
                              _selectGeneration(context
                                  .read<AuthenticationBloc>()
                                  .masterData
                                  .generations[index]);
                            });
                      },
                    )
                  ],
                ),
              ),
            ),

            // Continue Button
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  ContinueButton(
                    buttonAction: _selected.isNotEmpty
                        ? () {
                            Navigator.of(context).pushNamed('/signup5');
                          }
                        : null,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
}
