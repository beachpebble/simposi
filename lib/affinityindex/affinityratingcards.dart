/*
*  affinityratingcards.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/survey.dart';
import 'package:simposi_app_v4/model/survey_required.dart';

class AffinityRatingCard extends StatelessWidget {
  final SurveyRequired surveyRequired;

  const AffinityRatingCard({Key? key, required this.surveyRequired})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // HEADER
              const SizedBox(height: 20),
              const Text(
                'Want to meet again?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: SimposiAppColors.simposiDarkGrey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Simposi uses affinity matching to improve or prevent you from meeting again. Meet people you like more often or stop meeting those you don\'t.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // RATING CARDS
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    // CARD BACKGROUND IMAGE
                    SizedBox(
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
                                  return const LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.transparent],
                                  ).createShader(Rect.fromLTRB(
                                      0, 100, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: CachedNetworkImage(
                                  imageUrl: surveyRequired.userPhoto,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: AppProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ) /*ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                "assets/images/userrating.png",
                                fit: BoxFit.cover,
                              ),
                            )*/
                                ,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // CARD EVENT DETAILS
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surveyRequired.userName,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              color: SimposiAppColors.simposiDarkGrey,
                            ),
                          ),
                          Text(
                            surveyRequired.eventName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: SimposiAppColors.simposiDarkGrey,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd – kk:mm a')
                                .format(surveyRequired.eventDate),
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // TODO: Turn these into buttons
              // RATING BUTTONS
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<SurveyBloc>().add(SurveySendEvent(Survey(
                            userId: surveyRequired.id,
                            eventId: surveyRequired.eventId,
                            rate: 4)));
                        AutoRouter.of(context)
                            .push(const YouLikeEachOtherRoute());
                      },
                      child: Image.asset(
                        "assets/images/ratingheart1.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  // TODO: Record rating AND diplay next affinity card or home
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<SurveyBloc>().add(SurveySendEvent(Survey(
                            userId: surveyRequired.id,
                            eventId: surveyRequired.eventId,
                            rate: 3)));
                      },
                      child: Image.asset(
                        "assets/images/ratinglike.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),

                  // TODO: Record rating AND display next affinity card or home
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<SurveyBloc>().add(SurveySendEvent(Survey(
                            userId: surveyRequired.id,
                            eventId: surveyRequired.eventId,
                            rate: 2)));
                      },
                      child: Image.asset(
                        "assets/images/ratingneutral.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),

                  // TODO: Record rating AND display next affinity card or home
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<SurveyBloc>().add(SurveySendEvent(Survey(
                            userId: surveyRequired.id,
                            eventId: surveyRequired.eventId,
                            rate: 1)));
                      },
                      child: Image.asset(
                        "assets/images/ratingmeh.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(
                            ReportUserRoute(surveyRequired: surveyRequired));
                      },
                      child: Image.asset(
                        "assets/images/ratinghate.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                children: const [
                  Text(
                    'This information will never be shared with anyone.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
