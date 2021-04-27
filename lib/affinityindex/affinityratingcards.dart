/*
*  affinityratingcards.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';


class AffinityRatingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(

    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [

              // HEADER
              SizedBox(height: 20),
              Text('Want to meet again?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 17,
                color: SimposiAppColors.simposiDarkGrey,
              ),),
              SizedBox(height: 10),
              Text('Simposi uses affinity matching to improve or prevent you from meeting again. Meet people you like more often or stop meeting those you don\'t.',
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // RATING CARDS
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  // CARD BACKGROUND IMAGE
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
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
                                  "assets/images/userrating.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // CARD EVENT DETAILS
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 30),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Flora',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: SimposiAppColors.simposiDarkGrey,
                          ),),
                        Text('Ditch Fashion Show',
                          style: TextStyle(
                            fontSize: 17,
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
                ],
              ),

              // TODO: Turn these into buttons
              // RATING BUTTONS
              SizedBox(height: 30),
              Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).pushNamed('/connect',),
                    },
                    child: Image.asset("assets/images/ratingheart1.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                // TODO: Record rating AND diplay next affinity card or home
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset("assets/images/ratinglike.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                // TODO: Record rating AND display next affinity card or home
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset("assets/images/ratingneutral.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                // TODO: Record rating AND display next affinity card or home
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset("assets/images/ratingmeh.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).pushNamed('/reportuser',),
                    },
                    child: Image.asset("assets/images/ratinghate.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                ],
              ),
              SizedBox(height: 20),

              Column(
                children: [
                  Text('This information will never be shared with anyone.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),

  );
}
