/*
*  createevent4gender.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

import 'create_event_screen.dart';
import 'cubit/event_edit_cubit.dart';

class CreateEvent4 extends CreateEventScreen {
  CreateEvent4({bool editMode = false}) : super(editMode: editMode);

  @override
  _SignUpForm2State createState() => _SignUpForm2State();
}

class _SignUpForm2State extends CreateEventScreenState<CreateEvent4> {
  Set<Gender> _selected = {};
  late bool _isLgbt;

  @override
  void initState() {
    super.initState();
    _isLgbt = widget.editMode
        ? context.read<ProfileRepository>().profile.userMeta?.wantToMeetLgbt ?? false
        : context.read<EventEditCubit>().lgbt;
    _selected = widget.editMode
        ? context.read<ProfileRepository>().profile.userMeta?.wantToMeetGender?.toSet() ?? {}
        : context.read<EventEditCubit>().wantToMeetGender ?? {};
  }

  void _selectGender(Gender gender) {
    setState(() {
      if (_selected.contains(gender))
        _selected.remove(gender);
      else
        _selected.add(gender);
    });
    if (!widget.editMode) {
      context.read<EventEditCubit>().stage4Gender(gender: _selected);
    }
  }

  void _selectLgbt() {
    setState(() {
      _isLgbt = !_isLgbt;
      if (!widget.editMode) {
        context.read<EventEditCubit>().stage4Lgbt(lgbt: _isLgbt);
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
                  value: getProgressValue(),
                  valueColor: const AlwaysStoppedAnimation(
                      SimposiAppColors.simposiDarkBlue),
                  backgroundColor: SimposiAppColors.simposiFadedBlue,
                ),
                const SizedBox(height: 70),
                Text(
                  AppLocalizations.of(context)!.wantToMeetTitle,
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
                      isSelected: _selected.contains(Gender.Male),
                      buttonAction: () {
                        _selectGender(Gender.Male);
                      }),
                  const SizedBox(height: 10),
                  BigGBSelectButton(
                      buttonLabel: 'Woman', //TODO Localize
                      isSelected: _selected.contains(Gender.Female),
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
          getFooter()
        ],
      ),
    );
  }

  @override
  VoidCallback? continueAction() => _selected.isNotEmpty
      ? () {
          AutoRouter.of(context).push(CreateEvent5GenerationsRoute());
        }
      : null;

  @override
  VoidCallback? saveAction() => _selected.isNotEmpty
      ? () {
          context
              .read<ProfileBloc>().add(ProfileUpdateWantToMeetGender(gender: _selected.toList(), isLgbt: _isLgbt));
        }
      : null;

  @override
  double progress() => 0.64;
}
