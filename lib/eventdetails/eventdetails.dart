/*
*  eventdetails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbars.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';


class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
        // TODO: Replace Invitation App Bar with Event App Bar based on RSVP Status (note: menu options differ based on if user created the event)
        appBar: // InvitationAppBar(),
      EventAppBar(), // add logic to change app bar based on status
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          children: [
            // TODO: Hide/Show this row/invitation card based on RSVP Status
            Row(
              children: [
                //INVITATION CARD
                InvitationCard(),
              ],
            ),
            Row(
              children: [
                // EVENT IMAGE
                Expanded(
                  // TODO: Replace Image URL with Image from Event
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 200, rect.width, rect.height));
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
                          // TODO: Pull Event Title from Event
                          Text(
                            'Ditch Fashion Show',
                            style: const TextStyle(
                              fontSize: 21,
                              color: SimposiAppColors.simposiDarkGrey,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // DATE & TIME
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 30),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TODO: Pull Date variable from Event
                                  Text(
                                    'Thursday, September 19',
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                  // TODO: Pull Time variable from Event
                                  Text('6:00pm'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // LOCATION
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 30),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TODO: Pull Location Name from Event
                                  Text(
                                    'Cobana Pool Bar',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: SimposiAppColors.simposiDarkGrey,
                                    ),
                                  ),
                                  // TODO: Pull Location Address from Event
                                  Text('11 Poulson St, Toronto, ON, M4A 2F1'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // RSVP COUNTS
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 30),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Who\'s Going',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: SimposiAppColors.simposiDarkGrey,
                                    ),
                                  ),
                                  // TODO: Pull Counts of RSVPs where Status = Accepted (I think we have a count field scoped for this so status might not be relevant)
                                  Text('1 Women, 2 Men, 1 LGBTQ'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(
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
                  Text(
                    'Organized for',
                    style: const TextStyle(
                      fontSize: 21,
                      color: SimposiAppColors.simposiDarkGrey,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                          const SizedBox(width: 10),
                          // TODO: Display Event Settings for Gender
                          Text('Women, Men, LGBTQ'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                          const SizedBox(width: 10),
                          // TODO: Display Event Settings for Generations
                          Text('Millennial, Gen X'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                          const SizedBox(width: 10),
                          // TODO: Display Event Settings for Income
                          Text('\$35k to \$50k, \$50k to \$75k'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(
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
                  Text(
                    'Description',
                    style: const TextStyle(
                      fontSize: 21,
                      color: SimposiAppColors.simposiDarkGrey,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TODO: Display Event Description
                  Text(
                      'Artists, Designers, Companies from different countries will present their collections on the Social Impact concept in order to explain how the fashion industry could be a powerful engine for the current society along the exhibition spaces for the people who decide to advertise during the event, where, apart the visibility, the presence of Influencers, Journalists and Photographers will do effort to present Artists, Fashion designers and Brands.'),
                  const SizedBox(height: 10),
                  // TODO: Display tag cloud... same chip style as picker in grey without ability to click. Display only the tags on the event
                  // TAG CLOUD
                  Container(),
                  // TODO: Display Map Location as square or rectangle. Click should request access to Google Maps or Apple Maps App
                  // MAP
                  Container(),
                ],
              ),
            ),
          ],
        ),
      );
}
