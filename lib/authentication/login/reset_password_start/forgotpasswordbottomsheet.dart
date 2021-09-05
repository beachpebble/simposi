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
import 'package:simposi_app_v4/global/widgets/formfields.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
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
  Widget build(BuildContext context) =>
      KeyboardDismisser(
        child: BlocConsumer<ForgotPasswordStartCubit, ForgotPasswordStartState>(
          listener: (context, state) {
            if (state is ForgotPasswordStartError)
              //TODO make localization
              showErrorToast("Code was not sent");
            else if (state is ForgotPasswordStartSuccess) {
              showInfoToast("Code was sent via SMS");
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                  '/resetPassword', arguments: phone);
            }
          },
          builder: (context, state) {
            return Container(
              color: Colors.black54,
              child: Container(
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 20),
                      Text(
                        'Recover Password',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: SimposiAppColors.simposiDarkBlue
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          'You will receive an SMS with a recovery code.'),
                      const SizedBox(height: 30),
                      // FORGOT PASSWORD FORM
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SimposiPhoneField(),
                            const SizedBox(height: 20),
                            state is ForgotPasswordStartLoading
                                ? AppProgressIndicator()
                                : ContinueButton(
                                buttonLabel: 'Reset Password',
                                buttonAction: _emailController.text.isNotEmpty
                                    ? () {
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
                                }
                                    : null),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: _contactSupport,
                          child: const Text(
                            'Contact Support',
                            style: const TextStyle(
                              color: SimposiAppColors.simposiDarkBlue,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                      const SizedBox(height: 150),
                    ],
                  )),
            );
          },
        ),
      );

  void _contactSupport() async {
    var url = 'mailto:<support@simposi.com>?subject=<Account Recovery>&body=<body>';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

}
