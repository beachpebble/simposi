/*
*  profilescreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';

import '../global/theme/elements/simposiappbar.dart';
import 'bloc/profile_edit_cubit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SimposiAppBar(
          // TODO: Insert username and city variables
          simposiTitle: context.read<ProfileEditCubit>().profile.userName,
          simposiSubTitle: Text(
            context.read<ProfileEditCubit>().profile.userPhone,
            style: const TextStyle(
              color: SimposiAppColors.simposiLightText,
              fontSize: 13,
            ),
          ),
          simposiAction: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
                icon: const Icon(Icons.settings_outlined,
                    color: SimposiAppColors.simposiLightText, size: 30),
                onPressed: () => {
                      Navigator.of(context).pushNamed('/profilemenu'),
                    }),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Image
            Expanded(
              child: Container(
                  child: CachedNetworkImage(
                imageUrl: context.read<ProfileEditCubit>().profile.profilePhoto,
                width: 100,
                height: 100,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: AppProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
            ),

            // Engagement Stats
            Container(
              color: Colors.white,
              height: 70,
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        // TODO: Turn these into a ListTile's
                        // TODO: Enable Profile Counters
                        children: <Widget>[
                          // TODO: Enable Invitation Counter (Counts every RSVP received regardless if it was accepted)
                          Text(
                            '10',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Invitations',
                            style: const TextStyle(
                              color: SimposiAppColors.simposiLightText,
                              fontSize: 13,
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // TODO: Enable Check In Counter (Counts everytime user checked in for an event)
                          Text(
                            '10',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Event Attended',
                            style: TextStyle(
                              color: SimposiAppColors.simposiLightText,
                              fontSize: 13,
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // TODO: Enable People Counter (Counts every affinity survey sent.)
                          Text(
                            '10',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'People Met',
                            style: TextStyle(
                              color: SimposiAppColors.simposiLightText,
                              fontSize: 13,
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),
            ),

            // Subscribe Footer Area
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text('Get Unlimited Access',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 10),
                  Text(
                    'Subscribe for unlimited access and \n meet as many people as you like.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 10),
                  // TODO: Update transition to draw bottom sheet instead of screen
                  SubscribeButton(
                    nextPage: '/subscribe',
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Free Users will always be able to \ncreate or attend one meetup per month.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      );
}
