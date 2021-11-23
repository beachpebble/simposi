/*
*  checkinbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbars.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_router.dart';
import 'bloc/check_in_bloc.dart';

// BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class CheckInButton extends StatelessWidget {
  final Rsvp rsvp;

  const CheckInButton({Key? key, required this.rsvp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: SimposiAppColors.simposiPink,
        shape: StadiumBorder(),
      ),

      // TODO: Enable Check In Button
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return CheckInPopup(rsvp: rsvp);
          },
        );
      },

      child: Text(
        "Check In",
        textAlign: TextAlign.center,
      ),
    );
  }
}

// CHECK IN BOTTOM SHEET
class CheckInPopup extends StatefulWidget {
  final Rsvp rsvp;

  const CheckInPopup({Key? key, required this.rsvp}) : super(key: key);

  @override
  _CheckInPopupState createState() => _CheckInPopupState();
}

class _CheckInPopupState extends State<CheckInPopup> {
  @override
  Widget build(BuildContext context) => Container(
        // Transparent Overlay
        color: Colors.black54,
        // Bottom Sheet
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.checkInCancelText1,
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkGrey,
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.checkInCancelText2,
                style: TextStyle(
                  color: SimposiAppColors.simposiDarkGrey,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.checkInCancelText3),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.checkInCancelText4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Image.asset("assets/images/airbaloon.png"),
              SizedBox(height: 20),
              // BUTTONS
              BlocConsumer<CheckInBloc, CheckInState>(
                listener: (context, state) {
                 if (state is CheckInSuccess) {
                   AutoRouter.of(context).push(
                       GroupFinderRoute(
                           event: widget.rsvp.event));
                 } else if (state is CheckInLocationPermission) {
                   AutoRouter.of(context).pushNativeRoute(
                       _permissionDialog(context, null));
                 }else if (state is CheckInError) {
                   showErrorToast(handleError(state.error, context));
                 }
                },
                builder: (context, state) {
                  return (state is CheckInLoading)
                      ? Column(
                          children: [AppProgressIndicator()],
                        )
                      : Column(
                          children: [
                            BigCheckInButton(
                                onClick: () => context.read<CheckInBloc>().add(CheckInEventSend(widget.rsvp))),
                            SizedBox(height: 10),
                            BigButton(
                              buttonLabel: AppLocalizations.of(context)!.checkInCancelRsvp,
                              buttonAction: () {
                                AutoRouter.of(context).pushNativeRoute(
                                    cancelEventDialog(context, widget.rsvp, false));
                              },
                              buttonColor: SimposiAppColors.simposiLightGrey,
                              textColor: SimposiAppColors.simposiDarkGrey,
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      );


  Route<Object?> _permissionDialog(BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.checkInPermissionDialogTitle),
          content: Text(AppLocalizations.of(context)!.checkInPermissionDialogContent),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text(AppLocalizations.of(context)!.checkInPermissionDialogSettings),
                onPressed: () {
                  AutoRouter.of(context).pop();
                  Geolocator.openAppSettings();
                }),
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context)!.checkInPermissionDialogCancel),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
