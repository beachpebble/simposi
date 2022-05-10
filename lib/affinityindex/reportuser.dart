/*
*  reportuser.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/model/survey.dart';
import 'package:simposi_app_v4/model/survey_required.dart';

class ReportUser extends StatefulWidget {
  final SurveyRequired surveyRequired;

  const ReportUser({Key? key, required this.surveyRequired}) : super(key: key);

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: HeaderFormAppBar(
          headerTitle: 'Report User',
          nextButtonLabel: 'Submit ',
          onNext: () {
            context.read<SurveyBloc>().add(SurveySendEvent(Survey(
                userId: widget.surveyRequired.id,
                eventId: widget.surveyRequired.eventId,
                rate: 0,
                reportText: _controller.text)));
            AutoRouter.of(context).pop();
          },
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Tell us what happened. If you just didn’t like this user '
                'and don’t want to see them again, go back and use the other '
                'unhappy face. This one is for reporting serious stuff only.',
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 40,
              ),
              TextField(
                maxLines: 25,
                controller: _controller,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: SimposiAppColors.simposiLightText,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type here...',
                  hintStyle: TextStyle(
                    color: SimposiAppColors.simposiLightGrey,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
