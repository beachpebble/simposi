/*
*  forgotpasswordbottomsheet.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/phone_field.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
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
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocConsumer<ForgotPasswordStartCubit, ForgotPasswordStartState>(
          listener: (context, state) {
            if (state is ForgotPasswordStartError)
              //TODO make localization
              showErrorToast("Code was not sent");
            else if (state is ForgotPasswordStartSuccess) {
              showInfoToast("Code was sent via SMS");
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/resetPassword', arguments: phone);
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
                            PhoneField(
                              controller: _phoneController,
                              onSave: (value) =>
                                  setState(() => phone = value),
                            ),
                            SizedBox(height: 10),
                            state is ForgotPasswordStartLoading
                                ? AppProgressIndicator()
                                : ContinueButton(
                                    buttonLabel: 'Reset Password',
                                    buttonAction: _phoneController.text.isNotEmpty ? () {
                                      final isValid =
                                          _formKey.currentState!.validate();

                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        print('Email: ${phone}');
                                        context
                                            .read<ForgotPasswordStartCubit>()
                                            .sendForgotPasswordRequest(
                                                phone: phone);
                                      }
                                    } : null),
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

}
