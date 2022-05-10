/*
*  pincodefields.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TODO: Finish Setup
class PinCodeFields extends StatefulWidget {
  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  final TextEditingController _verificationCodeController =
      TextEditingController(text: '');
  bool _isButtonDisabled = true;
  late String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: PinCodeTextField(
        length: 6,
        controller: _verificationCodeController,
        backgroundColor: Colors.transparent,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 200),
        textStyle: const TextStyle(color: Colors.black, fontSize: 24),
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 50,
            fieldWidth:
                ((MediaQuery.of(context).size.width * 0.8) - (5 * 7)) / 6,
            borderRadius: BorderRadius.circular(25),
            borderWidth: 1,
            inactiveColor: SimposiAppColors.simposiLightGrey,
            selectedColor: SimposiAppColors.simposiDarkBlue,
            disabledColor: SimposiAppColors.simposiLightGrey,
            activeColor: SimposiAppColors.simposiDarkBlue),
        onChanged: (value) => setState(() => errorText = value),
        appContext: context,
      ),
    );
  }
}
