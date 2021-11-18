/*
*  calendarcards.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/calendar/checkin/checkinbottomsheet.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';

import 'rsvp_indicator.dart';

class EventCard extends StatelessWidget {
  EventCard({Key? key, required this.eventModel}) : super(key: key);

  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // CLICK CARD ACTION
        child: InkWell(
          onTap: () => {
            AutoRouter.of(context)
                .push(EventDetailsRoute(eventModel: eventModel))
          },
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: eventModel.rsvp.image,
                height: 172,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
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

              // OVERLAY AND TEXT
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.black26,
                height: 172,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      eventModel.rsvp.title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(eventModel.rsvp.fullDate),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // MY INVITATIONS ICON (WAITING ICON)
              if (eventModel.isMine)
                Positioned(
                  top: 10,
                  left: 20,
                  child: Row(
                    children: [
                      Tooltip(
                        message:
                            'You planted the seed! \nwaiting for it to bear fruit',
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: TextStyle(
                          color: SimposiAppColors.simposiPink,
                        ),
                        child: Icon(
                          Icons.self_improvement,
                          color: SimposiAppColors.simposiLightGrey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

              // RSVP INDICATOR
              Positioned(
                bottom: 20,
                right: 20,
                child: RsvpIndicator(
                  acceptedCount: eventModel.rsvp.event.rsvpAccepted,
                ),
              ),

              // TODO: Trigger/Show Check In Button if Event is in Check In Status only
              // CHECK IN BUTTON
              if (eventModel.showCheckIn)
                Positioned(
                  top: 5,
                  right: 10,
                  child: CheckInButton(
                    rsvp: eventModel.rsvp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Create InviteCard
