/*
*  signup5activities.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5activities/selectable_chip.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import '../../../app_router.dart';
import 'signup5_activities_cubit.dart';

class SignUpForm5 extends StatelessWidget {
  final bool editMode;
  final double progress = 0.66;

  const SignUpForm5({Key? key, this.editMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => Signup5ActivitiesCubit(
            context.read<AppSetupCubit>().masterData.interests,
            context.read(),
            context.read(),
            editMode: editMode),
        child: Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: BasicFormAppBar(),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: BlocConsumer<Signup5ActivitiesCubit,
                      Signup5ActivitiesState>(
                    buildWhen: (prev, current) {
                      return prev.filtered != current.filtered ||
                          prev.nextEnabled != current.nextEnabled;
                    },
                    listener: (context, state) {
                      if (state is Signup5ActivitiesStateSuccessChange) {
                        Navigator.pop(context);
                      }
                      if (state is Signup5ActivitiesStateErrorChange) {
                        showErrorToast(handleError(state.error!, context));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          // Header
                          Container(
                            child: Column(
                              children: [
                                const SizedBox(height: 45),
                                LinearProgressIndicator(
                                  value: state.editMode ? 1 : progress,
                                  valueColor: const AlwaysStoppedAnimation(
                                      SimposiAppColors.simposiDarkBlue),
                                  backgroundColor:
                                      SimposiAppColors.simposiFadedBlue,
                                ),
                                const SizedBox(height: 70),
                                Text(
                                  'I like to ...',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: _searchBar(context),
                                ),
                              ],
                            ),
                          ),

                          // Body
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  primary: true,
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Wrap(
                                      runSpacing: -8.0,
                                      children: selectedActivityWidgets(
                                          state.filtered,
                                          state.selected,
                                          context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Footer
                          state is Signup5ActivitiesStatLoading
                              ? AppProgressIndicator()
                              : Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ContinueButton(
                                        buttonLabel: state.editMode
                                            ? "Save"
                                            : "Continue",
                                        buttonAction: state.nextEnabled
                                            ? state.editMode
                                                ? () {
                                                    context
                                                        .read<
                                                            Signup5ActivitiesCubit>()
                                                        .savePressed();
                                                  }
                                                : () {
                                                    AutoRouter.of(context).push(
                                                        SignUpForm6Route());
                                                  }
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
              );
            })),
      );

  List<Widget> selectedActivityWidgets(Set<Interest> interests,
      Set<Interest> selectedItems, BuildContext context) {
    return interests
        .map((item) => SelectableChip(
            key: ValueKey(item.id),
            selected: selectedItems.contains(item),
            title: item.title,
            onClick: (value) {
              value
                  ? context.read<Signup5ActivitiesCubit>().selectInterest(item)
                  : context
                      .read<Signup5ActivitiesCubit>()
                      .deselectInterest(item);
            }))
        .toList();
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          hintText: 'Search activity',
          suffixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) =>
            context.read<Signup5ActivitiesCubit>().search(value),
      ),
    );
  }
}
