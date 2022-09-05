/*
*  groupfinder.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simposi_app_v4/checkin/bloc/group_finder_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/event.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import 'expiration_timer.dart';
import 'group_locator.dart';

class GroupFinder extends StatelessWidget {
  final Event event;

  const GroupFinder({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupFinderBloc(
          profileBloc: context.read(),
          rsvpBloc: context.read(),
          calendarRepository: context.read(),
          profileRepository: context.read(),
          eventId: event.id)
        ..add(GroupFinderPermissionRefresh()),
      child: Scaffold(
        appBar: SimposiAppBar(
          simposiTitle: AppLocalizations.of(context)!.groupFinderTitle,
          simposiSubTitle: ExpirationTimer(
            eventDate: event.datetime.toLocal(),
          ),
          simposiAction: Row(
            children: [
              TextButton(
                child: const Text(
                  'Info',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  showErrorToast("Not implemented yet");
                  //context.read<ProfileBloc>().add(ProfileReload());
                  //AutoRouter.of(context).replace(AffinityRatingCardsRoute());
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        body: BlocConsumer<GroupFinderBloc, GroupFinderState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GroupFinderLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  state.userSelected != null
                      ? Expanded(
                          child: CachedNetworkImage(
                          imageUrl: state.userSelected!.user.imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const SizedBox(
                              height: 25, child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ))
                      : Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 100,
                                  color: SimposiAppColors.simposiDarkGrey
                                      .withOpacity(0.5),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .groupFinderSelectSomeoneExtended,
                                  style: const TextStyle().copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                  Container(
                    color: SimposiAppColors.simposiLightGrey,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(AppLocalizations.of(context)!
                              .groupFinderArrived(state.users.length + 1, '4')),
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    child: GroupLocator(
                      users: (state).users,
                      userSelected: state.userSelected,
                      startAngle: state.startAngle,
                    ),
                  )
                ],
              );
            } else if (state is GroupFinderLocationError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                      "Location is disabled, Reenable location in device settings")
                ],
              );
            } else if (state is GroupFinderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(handleError(state.error, context))],
                ),
              );
            } else if (state is GroupFinderNoPermissions) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No Location permission"),
                    TextButton(
                        onPressed: () {
                          Geolocator.openAppSettings();
                        },
                        child: const Text("Open settings")),
                    TextButton(
                        onPressed: () {
                          context
                              .read<GroupFinderBloc>()
                              .add(GroupFinderPermissionRefresh());
                        },
                        child: const Text("Reload"))
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Unknown error")],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
