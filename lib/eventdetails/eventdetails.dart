/*
*  eventdetails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/calendar/calendarwidgets/tags_cloud.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbars.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';

class EventDetails extends StatelessWidget {
  final EventModel eventModel;

  const EventDetails({Key? key, required this.eventModel}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        // TODO: Replace Invitation App Bar with Event App Bar based on RSVP Status (note: menu options differ based on if user created the event)
        appBar: // InvitationAppBar(),
            EventAppBar(),
        // add logic to change app bar based on status
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          children: [
            // TODO: Hide/Show this row/invitation card based on RSVP Status
            if (eventModel.isMine)
              Row(
                children: [
                  //INVITATION CARD
                  InvitationCard(
                    eventModel: eventModel,
                  ),
                ],
              ),
            Row(
              children: [
                // EVENT IMAGE
                Expanded(
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
                    child: CachedNetworkImage(
                      imageUrl: eventModel.rsvp.image,
                      height: 438,
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
                          Text(
                            eventModel.rsvp.title,
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
                                  Text(
                                    DateFormat('EEEE, MMMM dd')
                                        .format(eventModel.rsvp.fullDate),
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    DateFormat('hh:mm')
                                        .format(eventModel.rsvp.fullDate),
                                  ),
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
                                  Text(
                                    eventModel.rsvp.event.locationName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: SimposiAppColors.simposiDarkGrey,
                                    ),
                                  ),
                                  Text(eventModel.addressRepresentaion),
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
                                  Text('TODO: 1 Women, 2 Men, 1 LGBTQ'),
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
                          Text(eventModel.gendersString),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                          const SizedBox(width: 10),
                          Text(
                            eventModel.generationsString,
                            maxLines: 5,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                          const SizedBox(width: 10),
                          Text(eventModel.earningsString),
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
                  Text(eventModel.rsvp.event.description),
                  const SizedBox(height: 10),
                  TagsCloud(
                    interests: eventModel.rsvp.event.wantToMeetInterests,
                  ),
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
