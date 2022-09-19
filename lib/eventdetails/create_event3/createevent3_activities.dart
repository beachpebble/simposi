/*
*  signup5activities.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5activities/selectable_chip.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/interest.dart';

import '../../app_router.dart';
import 'createevent_activities_cubit.dart';

class CreateEvent3Activities extends StatelessWidget {
  final double progress = 0.48;

  const CreateEvent3Activities({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateEventActivitiesCubit(
            context.read<AppSetupCubit>().masterData.interests, context.read()),
        child: Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: BasicFormAppBar(),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: BlocConsumer<CreateEventActivitiesCubit,
                    CreateEventActivitiesState>(
                  buildWhen: (prev, current) {
                    return prev.filtered != current.filtered ||
                        prev.nextEnabled != current.nextEnabled;
                  },
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [
                        // Header
                        Column(
                          children: [
                            const SizedBox(height: 45),
                            LinearProgressIndicator(
                              value: progress,
                              valueColor: const AlwaysStoppedAnimation(
                                  SimposiAppColors.simposiDarkBlue),
                              backgroundColor:
                                  SimposiAppColors.simposiFadedBlue,
                            ),
                            const SizedBox(height: 70),
                            const Text(
                              'What kind of activity is this?',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: SimposiAppColors.simposiDarkGrey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Choose as many interests as you like.',
                              style: TextStyle(
                                color: SimposiAppColors.simposiLightText,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: _searchBar(context),
                            ),
                          ],
                        ),

                        // Body
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ContinueButton(
                                buttonAction: state.nextEnabled
                                    ? () {
                                        AutoRouter.of(context)
                                            .push(CreateEvent4Route());
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
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
                  ? context
                      .read<CreateEventActivitiesCubit>()
                      .selectInterest(item)
                  : context
                      .read<CreateEventActivitiesCubit>()
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
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) =>
            context.read<CreateEventActivitiesCubit>().search(value),
      ),
    );
  }
}
