/*
*  createevent5generations.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

import '../app_router.dart';
import 'create_event_screen.dart';
import 'cubit/event_edit_cubit.dart';

//AppLocalizations.of(context)!.wantToMeetTitle,

class CreateEvent5Generations extends CreateEventScreen {
  const CreateEvent5Generations({bool editMode = false}) : super(editMode: editMode);

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
      if (_selected.contains(generation)) {
        _selected.remove(generation);
      } else {
        _selected.add(generation);
      }
    });
    context.read<EventEditCubit>().stage5Generations(generation: _selected);
  }

  @override
  void initState() {
    super.initState();
    _selected = widget.editMode
        ? context
                .read<ProfileRepository>()
                .profile
                .userMeta
                ?.wantToMeetGenerations
                .toSet() ??
            {}
        : context.read<EventEditCubit>().wantToMeetGenerations ?? {};
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
                      .read<AppSetupCubit>()
                      .masterData
                      .generations
                      .length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return BigGBSelectButton(
                        buttonLabel: context
                            .read<AppSetupCubit>()
                            .masterData
                            .generations[index]
                            .title,
                        isSelected: _selected.contains(context
                            .read<AppSetupCubit>()
                            .masterData
                            .generations[index]),
                        buttonAction: () {
                          _selectGeneration(context
                              .read<AppSetupCubit>()
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
          AutoRouter.of(context).push(CreateEvent6Route());
        }
      : null;

  @override
  VoidCallback? saveAction() => _selected.isNotEmpty
      ? () {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdateWantToMeetGeneration(_selected.toList()));
        }
      : null;

  @override
  double progress() => 0.80;
}
