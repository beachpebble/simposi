/*
*  datetimepicker.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';


class SimposiDateTimePicker extends StatefulWidget {
  @override
  _SimposiDateTimePickerState createState() => _SimposiDateTimePickerState();
}

class _SimposiDateTimePickerState extends State<SimposiDateTimePicker> {
  DateTime dateTime = DateTime.now().add(Duration(hours: 2));

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: buildDatePicker(),
    ),

  );

  Widget buildDatePicker() => CupertinoDatePicker(
    initialDateTime: dateTime,
    mode: CupertinoDatePickerMode.dateAndTime,
    minimumDate: DateTime.now().add(Duration(hours: 1)),
    maximumDate: DateTime.now().add(Duration(days: 90)),
    onDateTimeChanged: (dateTime) =>
    setState( () => this.dateTime = dateTime )
  );

}




