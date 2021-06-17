/*
*  signup6activities.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/interest.dart';

class SignUpForm6 extends StatefulWidget {
  @override
  _SignUpForm6State createState() => _SignUpForm6State();
}

class _SignUpForm6State extends State<SignUpForm6> {
  // Set Variables
  double progress = 0.66;

  // TODO: Pass backend activities to this list

  Set<Interest> _filters = {};

  // FOR EACH ACTIVITY CREATE AN ACTIVITY BUTTON
  Iterable<Widget> get selectedActivityWidgets sync* {
    for (final Interest item
        in context.read<RegistrationCubit>().masterData.interests) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: InputChip(
          label: Text(item.title),
          elevation: 0,
          showCheckmark: false,
          selectedColor: SimposiAppColors.simposiDarkBlue,
          selected: _filters.contains(item),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(item);
              } else {
                _filters.remove(item);
              }
            });
          },
        ),
      );
    }
  }

  // SIGNUP FORM PAGE 6 LAYOUT
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                SizedBox(height: 45),
                Container(
                  child: LinearProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation(
                        SimposiAppColors.simposiDarkBlue),
                    backgroundColor: SimposiAppColors.simposiFadedBlue,
                  ),
                ),

                SizedBox(height: 70),

                Container(
                  child: Column(
                    children: [
                      // Header
                      Text(
                        'I like to ...',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: SimposiAppColors.simposiDarkGrey,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Choose as many interests as you like.',
                        style: TextStyle(
                          color: SimposiAppColors.simposiLightText,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 20),

                      // TODO: Implement a Search/Filter Bar for Activities
                      Container(),

                      // TAG CLOUD
                      Container(
                        child: Wrap(
                          runSpacing: -8.0,
                          children: selectedActivityWidgets.toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Continue Button
                Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      BigGBSelectButton(
                        buttonLabel: 'Continue',
                        buttonAction: _filters.isEmpty
                            ? null
                            : () {
                                context
                                    .read<RegistrationCubit>()
                                    .stage6(interests: _filters);
                                Navigator.of(context).pushNamed('/signup7');
                              },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }));
}

// VARIABLE FOR EACH ACTIVITY
class Activity {
  const Activity(this.label);

  final String label;
}
