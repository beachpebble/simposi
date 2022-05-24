/*
*  whoiwanttomeet_menu.dart
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

class EventSettings extends StatefulWidget {
  const EventSettings({Key? key}) : super(key: key);

  @override
  _EventSettingsState createState() => _EventSettingsState();
}

class _EventSettingsState extends State<EventSettings> {
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
                            Icons.people_outline,
                            color: SimposiAppColors.simposiPink,
                          ),
                          menuCardLabel: 'Gender & Community',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(CreateEvent4Route(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.cake_outlined,
                            color: SimposiAppColors.simposiLightBlue,
                            size: 20,
                          ),
                          menuCardLabel: 'Generations',
                          onTap: () {
                            AutoRouter.of(context).push(
                                CreateEvent5GenerationsRoute(editMode: true));
                          },
                        ),
                        SimposiMenuCard(
                          menuCardIcon: const Icon(
                            Icons.work_outline,
                            color: SimposiAppColors.simposiYellow,
                          ),
                          menuCardLabel: 'Who earn',
                          onTap: () {
                            AutoRouter.of(context)
                                .push(CreateEvent6Route(editMode: true));
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
