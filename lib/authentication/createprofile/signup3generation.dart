/*
*  signup3generation.dart
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

class SignUpForm3 extends StatefulWidget {
  @override
  _SignUpForm3State createState() => _SignUpForm3State();
}

class _SignUpForm3State extends State<SignUpForm3> {
  Set<Generation> _selected = {};
  double progress = 0.42;

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
                    const AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
            ),

            SizedBox(height: 70),

            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Header
                    Text('Generation...',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 20),

                    // iGen Button
                    Expanded(
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Continue Button
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  ContinueButton(
                    buttonAction: _selected.isNotEmpty
                        ? () {
                            context
                                .read<RegistrationCubit>()
                                .stage3(generations: _selected);
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
