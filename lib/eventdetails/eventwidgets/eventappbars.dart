/*
*  eventappbars.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:simposi_app_v4/bloc/rsvp_action/rsvp_action_bloc.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/eventdetails/cubit/event_edit_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import '../../app_router.dart';

class EventAppBar extends StatelessWidget with PreferredSizeWidget {
  // Variables
  final Size preferredSize;
  final EventModel eventModel;

  // Initiate Variables
  EventAppBar({Key, key, required this.eventModel})
      : preferredSize = const Size.fromHeight(60),
        super(key: key);

  // Screen
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: SimposiAppColors.simposiDarkGrey,
      leading: Builder(
        builder: (BuildContext context) {
          // CLOSE BUTTON
          return IconButton(
            alignment: Alignment.center,
            icon: const Icon(Icons.close,
                color: SimposiAppColors.simposiLightText),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      actions: [
        // TODO: Enable Share button to open the same bottomsheet with sharing options as is activated by the Invite Friend button in the dialog below (enable same function 2 spots in this file)
        // SHARE BUTTON
        IconButton(
          alignment: Alignment.center,
          visualDensity: const VisualDensity(
            horizontal: -2.0,
          ),
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.ios_share,
              color: SimposiAppColors.simposiLightText),
          onPressed: () {},
        ),
        // MENU BUTTON
        FocusedMenuHolder(
          menuItems:
              eventModel.isMine ? creatorMenu(context) : usualMenu(context),
          blurBackgroundColor: Colors.black45,
          openWithTap: true,
          onPressed: () {},
          child: const Icon(Icons.more_horiz,
              color: SimposiAppColors.simposiLightText),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  List<FocusedMenuItem> creatorMenu(BuildContext context) => [
        FocusedMenuItem(
          title: Text(
            AppLocalizations.of(context)!.eventDetailsMenuEditEvent,
            style: TextStyle(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),
          onPressed: () {
            context.read<EventEditCubit>().initEdit(eventModel.rsvp.event);
            AutoRouter.of(context).push(CreateEvent1Route());
          },
        ),
        FocusedMenuItem(
          title: Text(
            AppLocalizations.of(context)!.eventDetailsMenuCancelEvent,
            style: TextStyle(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),
          onPressed: () => AutoRouter.of(context)
              .pushNativeRoute(dialogBuilder(context, eventModel.rsvp, true)),
        ),
      ];

  List<FocusedMenuItem> usualMenu(BuildContext context) => [
        FocusedMenuItem(
          title: Text(
            AppLocalizations.of(context)!.eventDetailsMenuCancelRsvp,
            style: TextStyle(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),
          onPressed: () => AutoRouter.of(context)
              .pushNativeRoute(dialogBuilder(context, eventModel.rsvp)),
        ),
        FocusedMenuItem(
          // TODO: Enable Report Social Button
          title: Text(
            AppLocalizations.of(context)!.eventDetailsMenuReport,
            style: TextStyle(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),
          onPressed: () => Navigator.of(context).pushNamed('/reportevent'),
        ),
      ];

// DIALOGUE
}

Route<Object?> dialogBuilder(BuildContext context, Rsvp rsvp,
    [bool isCreator = false]) {
  return CupertinoDialogRoute<void>(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<RsvpActionBloc, RsvpActionState>(
        listener: (context, state) {
          if (state is RsvpActionSuccess) {
            AutoRouter.of(context).popUntilRouteWithName('SimposiHomeRoute');
          } else if (state is RsvpActionError) {
            showErrorToast(handleError(state.error, context));
            AutoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          return (state is RsvpActionLoading)
              ? CupertinoAlertDialog(
                  content: Column(
                  children: [
                    AppProgressIndicator(),
                  ],
                ))
              : CupertinoAlertDialog(
                  title: Text(
                      AppLocalizations.of(context)!.cancelEventDialogTitle),
                  content: Text(isCreator
                      ? AppLocalizations.of(context)!.cancelEventCreatorText
                      : AppLocalizations.of(context)!.cancelEventUserText),
                  actions: <Widget>[
                    CupertinoDialogAction(
                        child: Text(
                            AppLocalizations.of(context)!.cancelEventCancel),
                        onPressed: () => AutoRouter.of(context).pop()),
                    CupertinoDialogAction(
                        child: Text(
                            AppLocalizations.of(context)!.cancelEventConfirm),
                        onPressed: () {
                          context
                              .read<RsvpActionBloc>()
                              .add(RsvpActionCanceled(rsvp));
                        }),
                  ],
                );
        },
      );
    },
  );
}

