/*
*  signup4income.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/earning.dart';

import 'registration_profile_screen.dart';

class SignUpForm4 extends RegistrationProfileScreen {
  SignUpForm4({bool editMode = false}) : super(editMode: editMode);

  @override
  _SignUpForm4State createState() => _SignUpForm4State();
}

class _SignUpForm4State extends RegistrationProfileScreenState<SignUpForm4> {
  // double progress = 0.56;

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
          context.read<AppSetupCubit>().masterData.earnings.length)
        _selected.clear();
      else
        _selected.addAll(context.read<AppSetupCubit>().masterData.earnings);
    });
  }

  @override
  void initState() {
    super.initState();
    _selected = widget.editMode
        ? (context.read<ProfileBloc>().state as ProfileLoaded)
            .userProfile
            .earnings
            .toSet()
        : context.read<RegistrationCubit>().earnings ?? {};
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
                    value: getProgressValue(),
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                shrinkWrap: true,
                itemCount: context
                    .read<AppSetupCubit>()
                    .masterData
                    .earnings
                    .length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  Earning earning = context
                      .read<AppSetupCubit>()
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
                              .read<AppSetupCubit>()
                              .masterData
                              .earnings
                              .length,
                      buttonAction: () {
                        _selectAll();
                      }),
                  const SizedBox(height: 10),
                  getFooter()
                ],
              ),
            ),
          ],
        );
      }));

  @override
  VoidCallback? continueAction() => _selected.isEmpty
      ? null
      : () {
          AutoRouter.of(context).push(SignUpForm5Route());
        };

  @override
  double progress() => 0.56;

  @override
  VoidCallback? saveAction() => _selected.isNotEmpty
      ? () {
          context.read<ProfileBloc>().add(ProfileUpdateIncome(_selected));
        }
      : null;
}
