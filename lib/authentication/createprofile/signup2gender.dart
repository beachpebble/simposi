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
import 'package:simposi_app_v4/widgets/progress.dart';

class SignUpForm2 extends StatefulWidget {
  final bool editMode;

  const SignUpForm2({Key? key, this.editMode = true}) : super(key: key);

  @override
  _SignUpForm2State createState() => _SignUpForm2State();
}

class _SignUpForm2State extends State<SignUpForm2> {
  double progress = 0.22;

  Gender? _selected;
  late bool _isLgbt;

  @override
  void initState() {
    super.initState();
    _isLgbt = widget.editMode
        ? context.read<ProfileEditCubit>().profile.isLgbt
        : false;
    if (widget.editMode)
      _selected = context.read<ProfileEditCubit>().profile.gender;
  }

  void _selectGender(Gender gender) {
    setState(() {
      _selected = gender;
    });
  }

  void _selectLgbt() {
    setState(() {
      _isLgbt = !_isLgbt;
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
                  // Header Title
                  Text(
                    'I indentify as...',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: SimposiAppColors.simposiDarkGrey,
                    ),
                  ),
                  SizedBox(height: 20),

                  // TODO: Convert to Toggle Buttons
                  // Single Select Gender Buttons
                  BigGBSelectButton(
                      buttonLabel: 'Man', //TODO Localize
                      isSelected: _selected == Gender.Male,
                      buttonAction: () {
                        _selectGender(Gender.Male);
                      }),
                  SizedBox(height: 10),
                  BigGBSelectButton(
                      buttonLabel: 'Woman', //TODO Localize
                      isSelected: _selected == Gender.Female,
                      buttonAction: () {
                        _selectGender(Gender.Female);
                      }),

                  SizedBox(height: 30),
                  // Also Member Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          endIndent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                      ),
                      Text(
                        'Also member of',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 13,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          indent: 10,
                          color: SimposiAppColors.simposiLightText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
          Container(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                widget.editMode
                    ? profileEditNextButton()
                    : registrationNextButton(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registrationNextButton() {
    return BigGBSelectButton(
      buttonLabel: 'Continue',
      buttonAction: _selected != null
          ? () {
              context
                  .read<RegistrationCubit>()
                  .stage2(gender: _selected!, lgbt: _isLgbt);
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
                        context.read<ProfileEditCubit>().indentifyAs();
                      }
                    : null,
              );
      },
    );
  }
}
