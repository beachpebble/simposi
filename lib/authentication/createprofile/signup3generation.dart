/*
*  signup3generation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/generation.dart';

import 'cubit/registration_cubit.dart';
import 'registration_profile_screen.dart';

class SignUpForm3 extends RegistrationProfileScreen {
  const SignUpForm3({bool editMode = false}) : super(editMode: editMode);

  @override
  State createState() => _SignUpForm3State();
}

class _SignUpForm3State extends RegistrationProfileScreenState<SignUpForm3> {
  int? _selected;

  void _selectGeneration(Generation generation) {
    setState(() {
      _selected = generation.id;
    });
    context.read<RegistrationCubit>().setGenerations(generation: generation.id);
  }

  @override
  void initState() {
    super.initState();
    _selected = widget.editMode
        ? (context.read<ProfileBloc>().state as ProfileLoaded)
            .userProfile
            .generationId
        : context.read<RegistrationCubit>().generation;
  }

  @override
  Widget build(BuildContext context) {
    print("gen   ${context.read<AppSetupCubit>().masterData.generations}");
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: Column(
        children: [
          // Header
          Column(
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
                'Generation...',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 10),
            ],
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  context.read<AppSetupCubit>().masterData.generations.length,
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
                    isSelected: context
                            .read<AppSetupCubit>()
                            .masterData
                            .generations[index]
                            .id ==
                        _selected,
                    buttonAction: () {
                      _selectGeneration(context
                          .read<AppSetupCubit>()
                          .masterData
                          .generations[index]);
                    });
              },
            ),
          ),

          // Footer
          getFooter()
        ],
      ),
    );
  }

  @override
  VoidCallback? continueAction() => _selected != null
      ? () {
          AutoRouter.of(context).push(SignUpForm4Route());
        }
      : null;

  @override
  VoidCallback? saveAction() => _selected != null
      ? () {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdateGeneration(generation: _selected!));
        }
      : null;

  @override
  double progress() => 0.42;
}
