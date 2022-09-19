/*
*  alertsbackground.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

import '../app_router.dart';
import '../eventdetails/cubit/event_edit_cubit.dart';

class SimposiAlertsBackground extends StatelessWidget {
  const SimposiAlertsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/backgroundbell.png",
          ),
        ),
        const SizedBox(height: 30.0),
        Center(
          child: Text(
            "No Notifications",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 5.0),
        const Center(
          child: Text(
            "Check again later or invite others \n to meet you instead.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SmallPinkButton(
            buttonLabel: 'Meet Now',
            nextPage: () {
              context.read<EventEditCubit>().initCreate();
              AutoRouter.of(context).push(const CreateEvent1Route());
            }),
      ],
    );
  }
}
