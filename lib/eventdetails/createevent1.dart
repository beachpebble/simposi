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
  double progress = 0.22;
  // NOTE: Progress Bar is top widget in content and is extended behind a Transparent AppBar.
  // This is not a great solution but simplest I could conceive of, it will cause display to be weird on non-notched phones

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    extendBodyBehindAppBar: true,

    appBar: BasicFormAppBar(),

    body: Column(
      children: [
        SizedBox(height: 45),
        Container(
          child: LinearProgressIndicator(
            value: progress,
            valueColor: AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
            backgroundColor: SimposiAppColors.simposiFadedBlue,
          ),
        ),

        SizedBox(height: 70),

        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: Column(
              children: [

                Text('Post an activity \nand start meeting new people.',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: SimposiAppColors.simposiDarkGrey,
                  ),
                  textAlign: TextAlign.center,
                ),

                Container(
                  width: double.infinity,
                  child: AddEventImageButton(),
                ),

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
                SizedBox(height: 20),

                GestureDetector(
                  onTap:() => showSheet(
                    context,
                    onClicked: () {},
                    child: Text('Hello World!'),
                  ),
                  child: AbsorbPointer(
                    child: SimposiPlainField(
                        inputType: TextInputType.datetime,
                        fieldLabel: 'Date & Time',
                        validationLogic: (value) {
                          if (value!.length < 4) {
                            return 'Please enter a Title for your activity';
                          } else {
                            return null;
                          }
                        },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                SimposiLargeTextField(
                    fieldLabel: 'Description',
                    textAreaLines: 8,
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

        Container(
          padding: EdgeInsets.all(40),
          child:
          Column(
            children: [

              // TODO: Disable button until user has selected a gender (LGBTQ optional)
              // TODO: Make screen reusable by changing the Continue button to a save button when back is to profile menu?
              BigGBSelectButton(
                buttonLabel: 'Continue',
                buttonAction: () =>
                {
                  Navigator.of(context).pushNamed('/createevent2'),
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
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
              Text('Hello World!'),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Save'),
            onPressed: () => {
              Navigator.of(context).pushNamed('/home'),
            },
          ),
      ),
  );
}

