/*
*  calendarcards.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../global/routegenerator.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/calendar/calendarwidgets/checkinbottomsheet.dart';

// TODO: Create a Test list to iterate over?
// TODO: Create & Insert Variables for EventCard
// TODO: Create Sent Flag and Add Logic to Display it IF Creator = User
class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
  }) : super(key: key);

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
            Navigator.of(context).pushNamed('/eventdetails',),
          },
          child: Stack(
            children: <Widget>[

              // BACKGROUND IMAGE
              Image.asset("assets/images/eventcardbackground2.jpg",
              height: 172,
              width: double.infinity,
              fit: BoxFit.cover,
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
                    Text('Title',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text('Event Time',
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

              // TODO: Enable Icon to show only if the user is the owner of the event
              // MY INVITATIONS ICON (WAITING ICON)
              Positioned(
                top: 10,
                left: 20,
                child: Row(
                  children: [
                    Tooltip(
                      message: 'You planted the seed! \nwaiting for it to bear fruit',
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: TextStyle(
                        color: SimposiAppColors.simposiPink,
                      ),
                      child: Icon(Icons.self_improvement,
                      color: SimposiAppColors.simposiLightGrey,
                      size: 30,),
                    ),
                  ],
                ),
              ),

              // RSVP INDICATOR
              Positioned(
                bottom: 20,
                right: 20,
                child:
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Tooltip(
                      message: 'People who said yes!',
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: TextStyle(
                        color: SimposiAppColors.simposiPink,
                      ),
                      child: Column(
                        children: [
                          // TODO: Enable IF ELSE statement on these dots for how many people have RSVPd (Pink or LightGrey)
                          // TODO: Color from bottom to top as RSVPs come in
                          Icon(Icons.circle,
                            color: SimposiAppColors.simposiLightGrey,
                            size: 10,
                          ),
                          SizedBox(height: 5),
                          Icon(Icons.circle,
                            color: SimposiAppColors.simposiLightGrey,
                            size: 10,
                          ),
                          SizedBox(height: 5),
                          Icon(Icons.circle,
                            color: SimposiAppColors.simposiLightGrey,
                            size: 10,
                          ),
                          SizedBox(height: 5),
                          Icon(Icons.circle,
                            color: SimposiAppColors.simposiLightGrey,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // TODO: Trigger/Show Check In Button if Event is in Check In Status only
              // CHECK IN BUTTON
              Positioned(
                top: 5,
                right: 10,
                child: CheckInButton(),
              ),

            ],
          ),
        ),
      ),




    );
  }
}


// TODO: Create InviteCard
