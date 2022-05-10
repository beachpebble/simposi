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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  Row(
                    children: [
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
                  SizedBox(height: 2),
                  Row(
                    children: [
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
              child: Container(
                //     height: MediaQuery.of(context).size.height * 0.6,
                //    width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/profileplaceholder.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Message
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 40),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
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
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You',
                        style: TextStyle(
                          fontSize: 17,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/images/ratingheart1.png',
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'like each other',
                        style: TextStyle(
                          fontSize: 17,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'It takes at least 50hrs to make it official so keep it going by connecting IRL.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ShareDetailsButton(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      );
}
