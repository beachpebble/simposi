/*
*  createnewpassowrd.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../authenticationwidgets/forgotpasswordbottomsheet.dart';
import '../../global/routegenerator.dart';
import '../../global/theme/elements/simposiicons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';



class CreateNewPassword extends StatefulWidget {
  // Set Variables
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  // Set Variables
  String password = ' ';
  String confirmPassword = ' ';
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,

          // TODO: Display BasicAppBar ONLY IF coming from ProfileMenu, else display none

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

                        // HEADER LOGO
                        Container(
                          height: 300,
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
                              // TITLE
                              Text('Create New Password',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color: SimposiAppColors.simposiDarkGrey,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Passwords must be at least 8 characters long.',
                                textAlign: TextAlign.center,),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),

                        // TODO: Validate Account Exists and Start a New Page Stack with Home
                        // RESET PASSWORD FORM
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [



                                // EMAIL FIELD
                                _passwordField(),
                                SizedBox(height: 10),

                                // PASSWORD FIELD
                                _confirmPassword(),
                                SizedBox(height: 10),
                                BigGBSelectButton(
                                    buttonLabel: 'Set New Password',
                                    buttonAction: () {
                                      final isValid = _formKey.currentState!
                                          .validate();

                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        print('Password: ${password}');
                                        Navigator.of(context).pushReplacementNamed(
                                            '/home');
                                      }
                                    }
                                ),
                                SizedBox(height: 10),

                                // FORGOT PASSWORD BUTTON CONTAINED IN BOTTOM SHEET (NOT IN BUTTONS)
                                SimposiTextButton(
                                  buttonLabel: 'Contact Support',
                                  nextPage: '/profile',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),

                              ],
                            ),
                          ),
                        ),

                        // FOOTER
                        Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '© 2021 Simposi Inc.',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
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


  // PASSWORD FIELD
  Widget _passwordField() =>
      TextFormField(
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
          labelText: ' New Password',
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


  // CONFIRM PASSWORD FIELD
  Widget _confirmPassword() =>
      TextFormField(
        controller: _confirmPasswordController,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: _confirmPasswordVisible,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          labelText: ' Confirm Password',
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiLightText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),

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

          suffixIcon: _confirmPasswordController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
              icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons
                  .visibility_off,
                  size: 20, color: SimposiAppColors.simposiLightGrey),
              onPressed: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              }),

        ),

        // VALIDATION LOGIC
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please confirm password';
          }
          if (value != _passwordController.text)
            return 'Passwords do not match';
          else {
            return null;
          }
        },

        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => confirmPassword = value!),
      );


}