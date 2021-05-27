/*
*  eventdetails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbar.dart';
import '../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import '../global/routegenerator.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6activities.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(

    appBar: EventAppBar(),

    body: ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            // EVENT IMAGE
            Expanded(
                // TODO: Replace Image URL with Variable from Profile
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 200, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    "assets/images/eventcardbackground2.jpg",
                    fit: BoxFit.cover,
                    height: 438,
                  ),
                ),
            ),
          ],
        ),

        // EVENT DETAILS SECTION
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ditch Fashion Show',
                        style: TextStyle(
                          fontSize: 21,
                          color: SimposiAppColors.simposiDarkGrey,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10),

                      // DATE & TIME
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Thursday, September 19',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: SimposiAppColors.simposiDarkGrey,
                                ),
                              ),
                              Text('6:00pm'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // LOCATION
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cobana Pool Bar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: SimposiAppColors.simposiDarkGrey,
                                ),
                              ),
                              Text('11 Poulson St, Toronto, ON, M4A 2F1'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // RSVP COUNTS
                      Row(
                        children: [
                          Icon(Icons.person_outline,
                              size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Who\'s Going',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: SimposiAppColors.simposiDarkGrey,
                                ),
                              ),
                              Text('1 Women, 2 Men, 1 LGBTQ'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),

        // ORGANIZED FOR
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Organized for',
                style: TextStyle(
                  fontSize: 21,
                  color: SimposiAppColors.simposiDarkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle,
                      color: SimposiAppColors.simposiDarkBlue,
                      size: 10),
                      SizedBox(width: 10),
                      Text('Women, Men, LGBTQ'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          color: SimposiAppColors.simposiDarkBlue,
                          size: 10),
                      SizedBox(width: 10),
                      Text('Millennial, Gen X'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          color: SimposiAppColors.simposiDarkBlue,
                          size: 10),
                      SizedBox(width: 10),
                      Text('\$35k to \$50k, \$50k to \$75k'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),

        Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),

        // DESCRIPTION
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description',
                style: TextStyle(
                  fontSize: 21,
                  color: SimposiAppColors.simposiDarkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Text('Artists, Designers, Companies from different countries will present their collections on the Social Impact concept in order to explain how the fashion industry could be a powerful engine for the current society along the exhibition spaces for the people who decide to advertise during the event, where, apart the visibility, the presence of Influencers, Journalists and Photographers will do effort to present Artists, Fashion designers and Brands.'),
              SizedBox(height: 10),
              // TAG CLOUD
              Container(
              ),
              // MAP
              Container(

              ),
            ],
          ),
        ),
      ],
    ),

  );
}
