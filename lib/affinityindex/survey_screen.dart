/*
*  affinityratingcards.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/survey/survey_bloc.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/survey_required.dart';

import 'affinityratingcards.dart';

class SurveyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SurveyBloc, SurveyState>(
          builder: (context, state) {
            if (state is SurveyError) {
              return _error(handleError(state.error, context));
            } else if (state is SurveyProcess) {
              return _survey(state.surveyRequired);
            } else {
              return _loading();
            }
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Loading surveys"),
        Row(
          children: [AppProgressIndicator()],
        )
      ],
    );
  }

  Widget _error(String errorText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Error loading surveys",
          textAlign: TextAlign.center,
        ),
        Text(
          errorText,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [AppProgressIndicator()],
        )
      ],
    );
  }

  Widget _survey(SurveyRequired surveyRequired) {
    return AffinityRatingCard(surveyRequired: surveyRequired);
  }
}
