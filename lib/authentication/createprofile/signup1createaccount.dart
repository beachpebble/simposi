/*
*  signup1createaccount.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../global/theme/elements/simposibuttons.dart';
import '../authenticationwidgets/privacytoufooter.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';


class SignUpForm1 extends StatefulWidget {
  @override
  _SignUpForm1State createState() => _SignUpForm1State();
}

class _SignUpForm1State extends State<SignUpForm1> {

  // Set Variables
  String name = ' ';
  String email = ' ';
  String password = ' ';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,

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

                        // HEADER
                        Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Signup and start \n meeting new people.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: SimposiAppColors.simposiDarkGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: 20),
                              // TODO: ENABLE IMAGE PICKER & ERROR MESSAGE IF NO IMAGE ON SUBMIT
                              //  PHOTO UPLOAD FIELD
                              AddPhotoButton(),
                            ],
                          ),
                        ),

                        // CREATE ACCOUNT FORM
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [


                                SizedBox(height: 40),

                                // NAME FIELD
                                _nameField(),
                                SizedBox(height: 15),

                                // EMAIL FIELD
                                _emailField(),
                                SizedBox(height: 15),

                                // PASSWORD FIELD
                                _passwordField(),
                                SizedBox(height: 15),

                                // TODO: CREATE INACTIVE ACCOUNT ON SUBMIT WITH USERID, CONTINUE STORING VALUES AGAINST ACCOUNT WITH EACH SIGNUP SCREEN
                                // SUBMIT BUTTON
                                BigGBSelectButton(
                                    buttonLabel: 'Submit',
                                    buttonAction: () {
                                      final isValid = _formKey.currentState!
                                          .validate();

                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        print('Name: ${name}');
                                        print('Email: ${email}');
                                        print('Password: ${password}');
                                        Navigator.of(context).pushNamed('/signup2');
                                      }
                                    }
                                ),
                                SizedBox(height: 10),

                                // LOGIN BUTTON
                                SimposiTextButton(
                                  buttonLabel: "Log In",
                                  nextPage: '/login',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // FOOTER
                        Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrivacyTOUFooter(
                                footerColor: SimposiAppColors.simposiLightText,
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


  // NAME FIELD
  Widget _nameField() =>
      TextFormField(
        controller: _nameController,
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
          labelText: ' Name',
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
              )
          ),

          // Error State
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _nameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close,
                      size: 20, color: SimposiAppColors.simposiLightGrey),
                  onPressed: () => _nameController.clear(),
                ),

        ),

        // Validation Logic
        validator: (value) {
          if (value!.length < 4) {
            return 'Please enter your first name';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => name = value!),
      );


  Widget _emailField() =>
      TextFormField(
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

          suffixIcon: _emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
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
          else {
            return null;
          }
        },

        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => email = value!),
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
          labelText: ' Password',
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

          suffixIcon: IconButton(
              color: SimposiAppColors.simposiLightGrey,
              iconSize: 20,
              icon: _passwordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              }),

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