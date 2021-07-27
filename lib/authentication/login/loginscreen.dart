/*
*  loginscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../authenticationwidgets/forgotpasswordbottomsheet.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';



class LoginScreen extends StatefulWidget {
  // Set Variables
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Set Variables
  String phone = ' ';
  String password = ' ';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // LOGO HEADER
                        Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/logo.png"),
                              const Text(
                                'simposi',
                                style: const TextStyle(
                                  color: SimposiAppColors.simposiDarkBlue,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              )
                            ],
                          ),
                        ),

                        // LOGIN FORM
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [

                                // EMAIL FIELD
                                _phoneField(),
                                const SizedBox(height: 10),

                                // PASSWORD FIELD
                                _passwordField(),
                                const SizedBox(height: 10),
                                BigGBSelectButton(
                                    buttonLabel: 'Log In',
                                    buttonAction: () {
                                      final isValid = _formKey.currentState!
                                          .validate();

                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        print('Phone: ${phone}');
                                        print('Password: ${password}');
                                        Navigator.of(context).pushReplacementNamed('/home');
                                      }
                                    }
                                ),
                                SizedBox(height: 10),

                                // FORGOT PASSWORD BUTTON CONTAINED IN BOTTOM SHEET (NOT IN BUTTONS)
                                ForgotPasswordTextButton(),

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
                              TextButton(
                                child: Text('Register',
                                  style: TextStyle(
                                    color: SimposiAppColors.simposiDarkBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () => {
                                  Navigator.of(context).pushReplacementNamed('/signup1'),
                                },
                              ),
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


  // PHONE FIELD
  Widget _phoneField() =>
      TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        decoration: InputDecoration(
          labelText: ' Phone Number',

          suffixIcon: _phoneController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                icon: Icon(Icons.close,
                    size: 20,
                    color: SimposiAppColors.simposiLightGrey),
                    onPressed: () => _phoneController.clear(),
              ),
        ),

        // PHONE VALIDATION LOGIC
        validator: (value) {

          // IF Empty
          if (value!.isEmpty) {
            return 'Phone Required';
          }
          if (value.length < 10) {
            return 'Must be at least 10 characters';
          }
          else {
            return null;
          }
        },

        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => phone = value!),
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

    decoration: InputDecoration(
      labelText: ' Password',
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
