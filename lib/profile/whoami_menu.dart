/*
*  whoami_menu.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/profile/elements/simposimenucard.dart';

import '../app_router.dart';

class InvitationSettings extends StatefulWidget {
  const InvitationSettings({Key? key}) : super(key: key);

  @override
  State createState() => _InvitationSettingsState();
}

class _InvitationSettingsState extends State<InvitationSettings> {
  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BasicFormAppBar(),
          body: Column(
            children: [
              // Menu List
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.perm_identity,
                            color: SimposiAppColors.simposiPink,
                          ),
                          menuCardLabel: 'I Identify as...',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(SignUpForm2Route(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.cake_outlined,
                            color: SimposiAppColors.simposiLightBlue,
                            size: 20,
                          ),
                          menuCardLabel: 'My Generations...',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(SignUpForm3Route(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.work_outline,
                            color: SimposiAppColors.simposiYellow,
                          ),
                          menuCardLabel: 'My Income Range...',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(SignUpForm4Route(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.directions_bike,
                            color: SimposiAppColors.simposiPink,
                          ),
                          menuCardLabel: 'Activities I like...',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(SignUpForm5Route(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.location_searching,
                            color: SimposiAppColors.simposiLightBlue,
                          ),
                          menuCardLabel: 'Location & Distance...',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(SignUpForm6Route(editMode: true));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/logosquare.png'),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Version 4.1.0',
                      style: TextStyle(
                        fontSize: 13,
                        color: SimposiAppColors.simposiLightText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
