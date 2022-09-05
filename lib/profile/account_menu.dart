/*
*  account_menu.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

import 'elements/simposimenucard.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  child: ListView(children: [
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.person_outline,
                        color: SimposiAppColors.simposiLightBlue,
                      ),
                      menuCardLabel: 'Account Settings',
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const EditProfileScreenRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.vpn_key_outlined,
                        color: SimposiAppColors.simposiPink,
                      ),
                      menuCardLabel: 'Change Password',
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const ChangePasswordScreenRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.markunread_mailbox_outlined,
                        color: SimposiAppColors.simposiYellow,
                        size: 20,
                      ),
                      menuCardLabel: 'Who am I',
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const InvitationSettingsRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.perm_contact_calendar_outlined,
                        color: SimposiAppColors.simposiLightBlue,
                        size: 20,
                      ),
                      menuCardLabel: 'Who I want to Meet',
                      onTap: () {
                        AutoRouter.of(context).push(const EventSettingsRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.local_hospital_outlined,
                        color: SimposiAppColors.simposiPink,
                      ),
                      menuCardLabel: 'Emergency Contact',
                      onTap: () {
                        AutoRouter.of(context)
                            .push(const EmergencyContactRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.help_outline_outlined,
                        color: SimposiAppColors.simposiYellow,
                      ),
                      menuCardLabel: 'FAQ      ',
                      onTap: () {
                        AutoRouter.of(context).push(const FAQScreenRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.sticky_note_2_outlined,
                        color: SimposiAppColors.simposiLightBlue,
                      ),
                      menuCardLabel: 'Terms of Use',
                      onTap: () {
                        Navigator.of(context).pushNamed('/tou');
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.privacy_tip_outlined,
                        color: SimposiAppColors.simposiPink,
                      ),
                      menuCardLabel: 'Privacy Policy',
                      onTap: () {
                        AutoRouter.of(context).push(const PrivacyScreenRoute());
                      },
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.question_answer_outlined,
                        color: SimposiAppColors.simposiYellow,
                      ),
                      menuCardLabel: 'Support',
                      onTap: () {},
                    ),
                    SimposiMenuCard(
                      menuCardIcon: const Icon(
                        Icons.exit_to_app,
                        color: SimposiAppColors.simposiLightBlue,
                      ),
                      menuCardLabel: 'Sign Out',
                      onTap: () {
                        AutoRouter.of(context)
                            .pushNativeRoute(_logoutDialog(context));
                      },
                    ),
                  ]),
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
      );

  Route<Object?> _logoutDialog(BuildContext context) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.logoutDialogTitle),
          content: Text(AppLocalizations.of(context)!.logoutDialogContent),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text(AppLocalizations.of(context)!.logoutDialogYes),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(LogOut());
                }),
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context)!.logoutDialogNo),
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
