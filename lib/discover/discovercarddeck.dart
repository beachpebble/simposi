/*
*  discovercarddeck.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


class DiscoverCardDeck extends StatefulWidget {
  @override
  _DiscoverCardDeckState createState() => _DiscoverCardDeckState();
}

class _DiscoverCardDeckState extends State<DiscoverCardDeck> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // CARD BACKGROUND
          Container(
            height: MediaQuery.of(context).size.width * 1.4,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Expanded(
                // TODO: Replace Image URL with Variable from Profile
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 100, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/eventcardbackground2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom:30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ditch Fashion Show',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),),
                  Text('Event Time',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),

                ],
              ),
          ),

// Insert RSVP Counter HERE

          Positioned(
            top: 20,
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


        ],
      ),
    );
  }
}
