/*
*  formfields.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TEXT FIELD WITH CLEAR FUNCTION
class SimposiFormFieldwClear extends StatelessWidget {
  final String inputType;
  final String fieldLabel;
  final validationLogic;
  final TextEditingController fieldController;

  const SimposiFormFieldwClear({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.validationLogic,
    required this.fieldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,
      style: TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: fieldLabel,
        contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
        ),

        // Initial State
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          ),
        ),

        // Focus State
        focusColor: SimposiAppColors.simposiDarkBlue,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiDarkBlue,
          ),
        ),

        // Focus Error State
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),

        // Error State
        errorStyle: TextStyle(
          color: SimposiAppColors.simposiPink,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),

        suffixIcon: fieldController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close,
                    size: 20, color: SimposiAppColors.simposiLightGrey),
                onPressed: () => fieldController.clear(),
              ),
      ),
      validator: validationLogic,
    );
  }
}

// PASSWORD FIELD
class SimposiPasswordField extends StatefulWidget {
  const SimposiPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  _SimposiPasswordFieldState createState() => _SimposiPasswordFieldState();
}

class _SimposiPasswordFieldState extends State<SimposiPasswordField> {
  String _password = ' ';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: _passwordVisible,
      showCursor: true,

      style: TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),

      decoration: InputDecoration(
        labelText: ' Password',
        contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
        ),

        suffixIcon: _passwordController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: SimposiAppColors.simposiLightGrey),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                }),

        // INITIAL STATE
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          ),
        ),

        // FOCUS STATE
        focusColor: SimposiAppColors.simposiDarkBlue,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiDarkBlue,
          ),
        ),

        // FOCUS ERROR STATE
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),

        // ERROR STATE
        errorStyle: TextStyle(
          color: SimposiAppColors.simposiPink,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),
      ),

      // VALIDATION LOGIC
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password Required';
        }
        if (value.length < 8) {
          return 'Must be at least 8 characters';
        } else {
          return null;
        }
      },

      // OUTPUT ACTIONS
      onSaved: (value) => setState(() => _password = value!),
    );
  }
}
