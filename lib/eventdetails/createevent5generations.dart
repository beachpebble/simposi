/*
*  createevent5generations.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/profile/bloc/profile_edit_cubit.dart';

import 'create_event_screen.dart';

//AppLocalizations.of(context)!.wantToMeetTitle,

class CreateEvent5Generations extends CreateEventScreen {
  CreateEvent5Generations({bool editMode = false}) : super(editMode: editMode);

  @override
  State<StatefulWidget> createState() {
    return _CreateEvent5GenerationsState();
  }
}

class _CreateEvent5GenerationsState
    extends CreateEventScreenState<CreateEvent5Generations> {
  Set<Generation> _selected = {};

  void _selectGeneration(Generation generation) {
    setState(() {
      if (_selected.contains(generation))
        _selected.remove(generation);
      else
        _selected.add(generation);
    });
    //context.read<RegistrationCubit>().setGenerations(generation: generation.id);
  }

  @override
  void initState() {
    super.initState();
    //TODO new bloc
    _selected = widget.editMode
        ? context.read<ProfileEditCubit>().profile.wantToMeetGenerations ?? {}
        : null ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: Column(
        children: [
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
          getFooter()
        ],
      ),
    );
  }

  @override
  VoidCallback? continueAction() => _selected.isNotEmpty
      ? () {
          Navigator.of(context).pushNamed('');
        }
      : null;

  @override
  VoidCallback? saveAction() => _selected.isNotEmpty
      ? () {
          context.read<ProfileEditCubit>().wantToMeetGeneration(_selected);
        }
      : null;

  @override
  double progress() => 0.42;
}
