/*
*  createevent7pickinvitation.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';

import '../app_router.dart';
import 'eventwidgets/pickinvitationthumbnails.dart';


class CreateEvent7 extends StatelessWidget {
  double progress = 1.0;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,

    appBar: BasicFormAppBar(),

    body: Column(
      children: [
        // Header
        Container(
          child: Column(
            children: [
              SizedBox(height: 45),
              LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                backgroundColor: SimposiAppColors.simposiFadedBlue,
              ),
              SizedBox(height: 70),
              Text('Pick an Invitation',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),

        // Body
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: (1.0 / 1.2),
                // TODO: Allow infinite scroll of active invitation cards in DB, remove the 10 tile limit from this generated list
                children: List.generate(10, (index) {
                  return PickInvitationThumbnail();
                }),
              ),
            ),
          ),
        ),

        // Footer
        Container(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
          child:
          Column(
            children: [
              // TODO: Disable Button until user has selected an invitation
              BigGBSelectButton(
                buttonLabel: 'Create Event',
                buttonAction: () => {
                AutoRouter.of(context)
                    .replace(SimposiHomeRoute())
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
