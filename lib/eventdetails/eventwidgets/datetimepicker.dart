/*
*  datetimepicker.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimposiDateTimePicker extends StatefulWidget {
  final Function(DateTime dt)? callback;
  final DateTime? initial;


  const SimposiDateTimePicker({Key? key, this.callback, this.initial}) : super(key: key);

  @override
  _SimposiDateTimePickerState createState() => _SimposiDateTimePickerState();
}

class _SimposiDateTimePickerState extends State<SimposiDateTimePicker> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: CupertinoDatePicker(
              initialDateTime: widget.initial?? DateTime.now().add(const Duration(hours: 1)),
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: DateTime.now().subtract(const Duration(days: 1)),//.add(Duration(hours: 1)),
              maximumDate: DateTime.now().add(const Duration(days: 90)),
              onDateTimeChanged: (dateTime) =>
                  setState(() => widget.callback?.call(dateTime))),
        ),
      );

}
