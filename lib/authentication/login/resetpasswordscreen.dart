/*
*  resetpasswordscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

import '../../app_router.dart';


class ResetPassword extends StatefulWidget {
  // Set Variables
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
                                      AutoRouter.of(context)
                                          .replace(SimposiHomeRoute());
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
