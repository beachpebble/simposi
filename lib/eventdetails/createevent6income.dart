/*
*  createevent6income.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import 'create_event_screen.dart';
import 'cubit/event_edit_cubit.dart';

class CreateEvent6 extends CreateEventScreen {
  const CreateEvent6({bool editMode = false}) : super(editMode: editMode);

  @override
  State createState() => _SignUpForm4State();
}

class _SignUpForm4State extends CreateEventScreenState<CreateEvent6> {
  Set<Earning> _selected = {};

  void _selectEarning(Earning earning) {
    setState(() {
      if (_selected.contains(earning)) {
        _selected.remove(earning);
      } else {
        _selected.add(earning);
      }
    });
    if (!widget.editMode) {
      context.read<EventEditCubit>().stage6Earnings(earnings: _selected);
    }
  }

  void _selectAll() {
    setState(() {
      if (_selected.length ==
          context.read<AppSetupCubit>().masterData.earnings.length) {
        _selected.clear();
      } else {
        _selected.addAll(context.read<AppSetupCubit>().masterData.earnings);
      }
    });

    if (!widget.editMode) {
      context.read<EventEditCubit>().stage6Earnings(earnings: _selected);
    }
  }

  @override
  void initState() {
    super.initState();
    _selected = widget.editMode
        ? context
                .read<ProfileRepository>()
                .profile
                .userMeta
                ?.wantToMeetEarnings
                .toSet() ??
            {}
        : context.read<EventEditCubit>().wantToMeetEarnings ?? {};
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
                  AppLocalizations.of(context)!.wantToMeetTitle,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10),
              ],
            ),

            // Body
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                shrinkWrap: true,
                itemCount:
                    context.read<AppSetupCubit>().masterData.earnings.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final earning =
                      context.read<AppSetupCubit>().masterData.earnings[index];
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
  Widget registrationNextButton() {
    return BlocConsumer<EventEditCubit, EventEditState>(
      listener: (context, state) {
        if (state is EventEditSuccess) {
          AutoRouter.of(context).replace(const SimposiHomeRoute());
        } else if (state is EventEditError) {
          showErrorToast(handleError(state.error, context));
        }
      },
      builder: (context, state) {
        return state is EventEditLoading
            ? AppProgressIndicator()
            : ContinueButton(
                buttonLabel: "Save",
                buttonAction: () {
                  context.read<EventEditCubit>().complete();
                });
      },
    );
  }

  @override
  VoidCallback? continueAction() => _selected.isEmpty
      ? null
      : () {
          AutoRouter.of(context).push(SignUpForm5Route());
        };

  @override
  double progress() => 0.96;

  @override
  VoidCallback? saveAction() => _selected.isNotEmpty
      ? () {
          context
              .read<ProfileBloc>()
              .add(ProfileUpdateWantToMeetIncome(_selected.toList()));
        }
      : null;
}
