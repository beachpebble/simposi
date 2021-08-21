/*
*  signup2gender.dart
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
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/profile/bloc/profile_edit_cubit.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';

class SignUpForm2 extends StatefulWidget {
  final bool editMode;

  const SignUpForm2({Key? key, this.editMode = false}) : super(key: key);

  @override
  _SignUpForm2State createState() => _SignUpForm2State();
}

class _SignUpForm2State extends State<SignUpForm2> {
  double progress = 0.28;

  Gender? _selected;
  late bool _isLgbt;

  @override
  void initState() {
    super.initState();
    _isLgbt = widget.editMode
        ? context.read<ProfileEditCubit>().profile.isLgbt
        : context.read<RegistrationCubit>().lgbt;
    _selected = widget.editMode
        ? context.read<ProfileEditCubit>().profile.gender
        : context.read<RegistrationCubit>().gender;
  }

  void _selectGender(Gender gender) {
    setState(() {
      _selected = gender;
      if (!widget.editMode) {
        context.read<RegistrationCubit>().stage2Gender(gender: _selected!);
      }
    });
  }

  void _selectLgbt() {
    setState(() {
      _isLgbt = !_isLgbt;
      if (!widget.editMode) {
        context.read<RegistrationCubit>().stage2Lgbt(lgbt: _isLgbt);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  valueColor:
                      const AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                  backgroundColor: SimposiAppColors.simposiFadedBlue,
                ),
                const SizedBox(height: 70),
                Text('I indentify as...',
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
              child: Column(
                children: [
                  BigGBSelectButton(
                      buttonLabel: 'Man', //TODO Localize
                      isSelected: _selected == Gender.Male,
                      buttonAction: () {
                        _selectGender(Gender.Male);
                      }),
                  const SizedBox(height: 10),
                  BigGBSelectButton(
                      buttonLabel: 'Woman', //TODO Localize
                      isSelected: _selected == Gender.Female,
                      buttonAction: () {
                        _selectGender(Gender.Female);
                      }),

                  const SizedBox(height: 30),
                  // Also Member Divider
                  Row(
                    children: [
                      Expanded(
                        child: const Divider(
                          endIndent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                      ),
                      const Text(
                        'Also member of',
                        style: const TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 13,
                        ),
                      ),
                      Expanded(
                        child: const Divider(
                          indent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Multi-Select Community Buttons
                  BigGBSelectButton(
                      buttonLabel: 'LGBTQ', //TODO Localize
                      isSelected: _isLgbt,
                      buttonAction: () {
                        _selectLgbt();
                      }),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
            child: Column(
              children: [
                widget.editMode
                    ? profileEditNextButton()
                    : registrationNextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registrationNextButton() {
    return ContinueButton(
      buttonAction: _selected != null
          ? () {
              Navigator.of(context).pushNamed('/signup3');
            }
          : null,
    );
  }

  Widget profileEditNextButton() {
    return BlocConsumer<ProfileEditCubit, ProfileEditState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) Navigator.of(context).pop();
      },
      builder: (context, state) {
        return state is ProfileEditLoading
            ? AppProgressIndicator()
            : BigGBSelectButton(
                buttonLabel: 'Save',
                buttonAction: _selected != null
                    ? () {
                        context.read<ProfileEditCubit>().indentifyAs(_selected!, _isLgbt);
                      }
                    : null,
              );
      },
    );
  }
}

