/*
*  reportevent.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formfields.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';

enum ReportOption { offensivephoto, offensivedescription, other }

class ReportEvent extends StatefulWidget {
  @override
  _ReportEventState createState() => _ReportEventState();
}

class _ReportEventState extends State<ReportEvent> {
  ReportOption? _reportOption = ReportOption.offensivephoto;

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,

      appBar: BasicFormAppBar(),

      body: LayoutBuilder(builder:
          (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        // Header
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Text('Why are you reporting this event?',
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text('Please describe why the nature of the offense.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB( 20, 20, 20, 0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile(
                                title: const Text('Offensive Photo'),
                                value: ReportOption.offensivephoto,
                                groupValue: _reportOption,
                                onChanged: (ReportOption? value) {
                                  setState(() {
                                    _reportOption = value;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Offensive Description'),
                                value: ReportOption.offensivedescription,
                                groupValue: _reportOption,
                                onChanged: (ReportOption? value) {
                                  setState(() {
                                    _reportOption = value;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Other'),
                                value: ReportOption.offensivedescription,
                                groupValue: _reportOption,
                                onChanged: (ReportOption? value) {
                                  setState(() {
                                    _reportOption = value;
                                  });
                                },
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: SimposiLargeTextField(
                            fieldLabel: 'Description',
                            textAreaLines: 15,
                            validationLogic: (value) {
                              if (value!.length < 4) {
                                return 'Please enter a description';
                              } else {
                                return null;
                              }
                            },
                          ),
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
                        buttonLabel: 'Submit',
                        // TODO: Send email to support@simposi.com, subject: Report Event - Name of Event & Date
                        buttonAction: () => {},
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }),
    ),
  );
}

