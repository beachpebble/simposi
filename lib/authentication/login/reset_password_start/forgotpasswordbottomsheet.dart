/*
*  forgotpasswordbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/widgets/progress.dart';
import 'package:url_launcher/url_launcher.dart';

import 'forgot_password_start_cubit.dart';

// FORGOT PASSWORD BOTTOM SHEET
class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  // Set Variables
  String phone = ' ';
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
        child: BlocConsumer<ForgotPasswordStartCubit, ForgotPasswordStartState>(
          listener: (context, state) {
            if (state is ForgotPasswordStartError)
              Fluttertoast.showToast(
                  msg: handleError(state.error, context),
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            else if (state is ForgotPasswordStartSuccess) {
              Fluttertoast.showToast(
                  msg: "Restore link was sent to email",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Container(
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
                      Text(
                          'Please enter your email\nto restore your password.'),
                      SizedBox(height: 30),
                      // FORGOT PASSWORD FORM
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _phoneField(),
                            SizedBox(height: 10),
                            state is ForgotPasswordStartLoading
                                ? AppProgressIndicator()
                                : BigGBSelectButton(
                                    buttonLabel: 'Reset Password',
                                    buttonAction: () {
                                      final isValid =
                                          _formKey.currentState!.validate();

                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        print('Email: ${phone}');
                                        context
                                            .read<ForgotPasswordStartCubit>()
                                            .sendForgotPasswordrequest(
                                                phone: phone);
                                      }
                                    }),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                          onPressed: _contactSupport,
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
            );
          },
        ),
      );

  void _contactSupport() async {
    var url = 'mailto:<email address>?subject=<subject>&body=<body>';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  // EMAIL FIELD
  Widget _phoneField() => TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.number,
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
          labelText: 'Phone',
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

        // EMAIL VALIDATION LOGIC
        validator: (value) {
          if (value == null || value.isEmpty == true) {
            return 'Phone Required';
          } else if (value.length < 10) {
            return 'Must be at least 10 characters';
          } else {
            return null;
          }
        },

        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => phone = value!),
      );
}
