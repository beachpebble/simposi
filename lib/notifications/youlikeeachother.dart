/*
*  youlikeeachother.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/notifications/widgets/sharemydetailsbottomcard.dart';

class YouLikeEachOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicFormAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Message Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        'It\'s a Match!',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Making new friends is easy',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: SimposiAppColors.simposiDarkGrey,
                          ),
                        ),
                      ),
                      // TODO: Enable this to work like email time Today, Yesterday, Friday,
                      Text('Yesterday'),
                    ],
                  ),
                ],
              ),
            ),

            // Users Image
            Expanded(
              // TODO: Replace Image URL with Variable from Profile
              child: Image.asset(
                "assets/images/profileplaceholder.png",
                fit: BoxFit.cover,
              ),
            ),

            // Message
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
              child: Column(
                children: [
                  Column(
                    children: const [
                      Text(
                        'Flora',
                        style: TextStyle(
                          color: SimposiAppColors.simposiDarkGrey,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Ditch Fashion Show',
                        style: TextStyle(
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text('May 18, 2021'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You',
                        style: TextStyle(
                          fontSize: 17,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/images/ratingheart1.png',
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'like each other',
                        style: TextStyle(
                          fontSize: 17,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'It takes at least 50hrs to make it official so keep it going by connecting IRL.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ShareDetailsButton(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      );
}
