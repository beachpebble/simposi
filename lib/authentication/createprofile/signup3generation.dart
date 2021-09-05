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
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/model/generation.dart';

import 'cubit/registration_cubit.dart';

class SignUpForm3 extends StatefulWidget {
  @override
  _SignUpForm3State createState() => _SignUpForm3State();
}

class _SignUpForm3State extends State<SignUpForm3> {
  Set<Generation> _selected = {};
  double progress = 0.42;

  void _selectGeneration(Generation generation) {
    setState(() {
      if (_selected.contains(generation))
        _selected.remove(generation);
      else
        _selected.add(generation);
    });
    context.read<RegistrationCubit>().setGenerations(generations: _selected);
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
            // Header
            Container(
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  LinearProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation(
                        SimposiAppColors.simposiDarkBlue),
                    backgroundColor: SimposiAppColors.simposiFadedBlue,
                  ),
                  const SizedBox(height: 70),
                  Text(
                    'Generation...',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
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
                      return const SizedBox(height: 10);
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
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
              child: Column(
                children: [
                  ContinueButton(
                    buttonAction: _selected.isNotEmpty
                        ? () {
                            Navigator.of(context).pushNamed('/signup4');
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
