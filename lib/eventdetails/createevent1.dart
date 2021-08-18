/*
*  createevent1.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/datetimepicker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/formfields.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/elements/dialoguewidget.dart';


class CreateEvent1 extends StatelessWidget {
  double progress = 0.14;
  // NOTE: Progress Bar is top widget in content and is extended behind a Transparent AppBar.
  // This is not a great solution but simplest I could conceive of, it will cause display to be weird on non-notched phones

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      appBar: BasicFormAppBar(),

      body: LayoutBuilder(builder:
        (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
        ),
          child: IntrinsicHeight(
            child: Container(
              child: Column(
                children: [
                // Header
                Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      LinearProgressIndicator(
                        value: progress,
                        valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                        backgroundColor: SimposiAppColors.simposiFadedBlue,
                      ),
                      const SizedBox(height: 70),
                      Text('Post an activity \nand start meeting new people.',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: AddEventImageButton(),
                      ),
                    ],
                  ),
                ),

                // Body
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Column(
                      children: [
                        SimposiCounterField(
                            inputType: TextInputType.text,
                            fieldLabel: 'Title',
                            counterLength: 60,
                            validationLogic: (value) {
                              if (value!.length < 4) {
                                return 'Please enter a Title for your activity';
                              } else {
                                return null;
                              }
                            },
                        ),
                        const SizedBox(height: 10),

                        GestureDetector(
                          onTap:() => showSheet(
                            context,
                            // TODO: Enable this to set the variable and write it into the form field
                            onClicked: () => {
                            Navigator.of(context).pushNamed('/createevent1')
                            },
                            child: Container(
                              height: 300,
                              child: SimposiDateTimePicker()
                            ),
                          ),
                          child: AbsorbPointer(
                            child: SimposiPlainField(
                                inputType: TextInputType.datetime,
                                fieldLabel: 'Date & Time',
                                validationLogic: (value) {
                                  if (value!.length < 4) {
                                    return 'Please enter a Date & Time';
                                  } else {
                                    return null;
                                  }
                                },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        SimposiLargeTextField(
                            fieldLabel: 'Description',
                            textAreaLines: 10,
                            validationLogic: (value) {
                              if (value!.length < 4) {
                                return 'Please enter a description';
                              } else {
                                return null;
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
                  child:
                  Column(
                    children: [
                      // TODO: Disable button until user has entered event details in all fields
                      BigGBSelectButton(
                        buttonLabel: 'Continue',
                        buttonAction: () => {
                          Navigator.of(context).pushNamed('/createevent2'),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
           ),
          ),
        ),
      );
    }),
  ),
);

  static void showSheet(
      BuildContext context, {
        required Widget child,
        required VoidCallback onClicked,
      }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
              child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Save'),
            onPressed: onClicked,
          ),
      ),
  );
}

