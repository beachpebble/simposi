/*
*  resetpasswordscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';


class ResetPassword extends StatefulWidget {

  final String token;

  const ResetPassword({Key? key, required this.token}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // Set Variables
  String email = ' ';
  String password = ' ';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,

      // TODO: Hide App Bar if user accesses Reset Password via a link (no back button if coming from link)
      appBar: BasicFormAppBar(),

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // LOGO HEADER
                      Container(
                        height: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/images/logo.png"),
                            Text(
                              'simposi',
                              style: TextStyle(
                                color: SimposiAppColors.simposiDarkBlue,
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Please enter your new password.'
                            ),
                          ],
                        ),
                      ),

                      // TODO: Validate Account Exists and Start a New Page Stack with Home (Tracy you need to learn how to reset the Page Stack instead of pushnamed)
                      // LOGIN FORM
                      Container(
                        height: 250,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [

                              // PASSWORD FIELD
                              _passwordField(),
                              SizedBox(height: 10),

                              // TODO: Disable Save Button until Password requirements met
                              BigGBSelectButton(
                                  buttonLabel: 'Save',
                                  buttonAction: () {
                                    final isValid = _formKey.currentState!
                                        .validate();

                                    if (isValid) {
                                      _formKey.currentState!.save();
                                      print('Password: ${password}');
                                      Navigator.of(context).pushReplacementNamed('/home');
                                    }
                                  }
                              ),
                              SizedBox(height: 10),


                            ],
                          ),
                        ),
                      ),

                      // Footer
                      Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              '© 2021 Simposi Inc.',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          }

      ),
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

    style: TextStyle(
      color: SimposiAppColors.simposiLightText,
      fontWeight: FontWeight.w500,
      fontSize: 15,
    ),

    decoration: InputDecoration(
      labelText: ' Email Address',
      contentPadding: EdgeInsets.all(20),
      labelStyle: TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      ),

      suffixIcon: _emailController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
        icon: Icon(Icons.close,
            size: 20, color: SimposiAppColors.simposiLightGrey),
        onPressed: () => _emailController.clear(),
      ),

      // INITIAL STATE
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          )),

      // FOCUS STATE
      focusColor: SimposiAppColors.simposiDarkBlue,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiDarkBlue,
          )),

      // FOCUS ERROR STATE
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiPink,
          )
      ),

      // ERROR STATE
      errorStyle: TextStyle(
        color: SimposiAppColors.simposiPink,
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiPink,
          )
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


  // PASSWORD FIELD
  Widget _passwordField() => TextFormField(
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
          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,
              size: 20, color: SimposiAppColors.simposiLightGrey),
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
          )
      ),

      // ERROR STATE
      errorStyle: TextStyle(
        color: SimposiAppColors.simposiPink,
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiPink,
          )
      ),

    ),

    // VALIDATION LOGIC
    validator: (value) {
      if (value!.isEmpty) {
        return 'Password Required';
      }
      if (value.length < 8) {
        return 'Must be at least 8 characters';
      }
      else {
        return null;
      }
    },

    // OUTPUT ACTIONS
    onSaved: (value) => setState(() => password = value!),
  );
}
