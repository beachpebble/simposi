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


class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime dateTime = DateTime.now().add(Duration(hours: 2));

  @override
  Widget build(BuildContext context) => CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: DateTime.now().add(Duration(hours: 1)),
          maximumDate: DateTime.now().add(Duration(days: 90)),
          onDateTimeChanged: (dateTime) =>
              setState( () => this.dateTime = dateTime )
      );

}


