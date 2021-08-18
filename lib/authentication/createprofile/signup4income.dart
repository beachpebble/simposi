/*
*  signup4income.dart
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

class SignUpForm4 extends StatefulWidget {
  @override
  _SignUpForm4State createState() => _SignUpForm4State();
}

class _SignUpForm4State extends State<SignUpForm4> {
  double progress = 0.56;

  Set<Earning> _selected = {};

  void _selectEarning(Earning earning) {
    setState(() {
      if (_selected.contains(earning))
        _selected.remove(earning);
      else
        _selected.add(earning);
    });
    context.read<RegistrationCubit>().setEarnings(earnings: _selected);
  }

  void _selectAll() {
    setState(() {
      if (_selected.length ==
          context.read<AuthenticationBloc>().masterData.earnings.length)
        _selected.clear();
      else
        _selected
            .addAll(context.read<AuthenticationBloc>().masterData.earnings);
    });
  }

  @override
  void initState() {
    super.initState();
    _selected = context.read<RegistrationCubit>().earnings ?? {};
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Column(
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
                    'Income Bracket...',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Body
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    // TODO: Convert to Single Select instead of multiselect
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: context
                          .read<AuthenticationBloc>()
                          .masterData
                          .earnings
                          .length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
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
                  ),
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Column(
                children: [
                  // TODO: Remove Select All Function from Signup
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
                  const SizedBox(height: 10),
                  ContinueButton(
                    buttonAction: _selected.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).pushNamed('/signup5activities');
                          },
                  ),
                ],
              ),
            ),
          ],
        );
      })
  );
}
