/*
*  forgotpasswordbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';



// FORGOT PASSWORD BOTTOM SHEET TRIGGER BUTTON (SPECIALIZED)
class ForgotPasswordTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: SimposiAppColors.simposiDarkBlue,
          textStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ],
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ForgotPasswordForm();
            },
          );
        },
      ),
    );
  }
}


// FORGOT PASSWORD BOTTOM SHEET
class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  // Set Variables
  String email = ' ';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Container(
          color: Colors.black54,
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Recover Password',
                    style: TextStyle(
                      color: SimposiAppColors.simposiDarkBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Please enter your email\nto restore your password.'),
                  SizedBox(height: 30),

                  // TODO: CONVERT TO FORM (IF NEEDED)
                  // FORGOT PASSWORD FORM
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _emailField(),
                        SizedBox(height: 10),

                        // TODO: ENABLE FORGOT PASSWORD BUTTON
                        // FORGOT PASSWORD BUTTON
                        BigGBSelectButton(
                            buttonLabel: 'Reset Password',
                            buttonAction: () {
                              final isValid = _formKey.currentState!
                                  .validate();

                              if (isValid) {
                                _formKey.currentState!.save();
                                print('Email: ${email}');
                                Navigator.of(context).pushReplacementNamed('/createpassword');
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    // TODO: Enable Contact Support button to open the users native email app to support@simposi.com
                      onPressed: () {},
                      child: Text(
                        'Contact Support',
                        style: TextStyle(
                          color: SimposiAppColors.simposiDarkBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                  SizedBox(height: 150),
                ],
              )),
        ),
  );


  // EMAIL FIELD
  Widget _emailField() => TextFormField(
    controller: _emailController,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    enableSuggestions: true,
    autocorrect: true,
    obscureText: false,
    showCursor: true,

    decoration: InputDecoration(
      labelText: ' Email Address',

      suffixIcon: _emailController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              icon: Icon(Icons.close,
                  size: 20,
                  color: SimposiAppColors.simposiLightGrey),
                  onPressed: () => _emailController.clear(),
            ),

    ),

    // EMAIL VALIDATION LOGIC
    validator: (value) {
      final pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      final regExp = RegExp(pattern);

      // IF Empty
      if (value!.isEmpty) {
        return 'Email Required';
      }
      // IF does not match RegEx pattern
      if (!regExp.hasMatch(value)) {
        return 'Enter a Valid Email';
      }
      // TODO: Add Validation for IF Account does not Exist, display Account does not exist message
      else {
        return null;
      }
    },

    // OUTPUT ACTIONS
    onSaved: (value) => setState(() => email = value!),
  );
}


