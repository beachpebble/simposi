/*
*  createnewpassowrd.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/validators.dart';
import 'package:simposi_app_v4/widgets/password_field.dart';
import 'package:simposi_app_v4/widgets/progress.dart';

import 'reset_password_complete_cubit.dart';

class CreateNewPassword extends StatefulWidget {
  final String? token;

  const CreateNewPassword({Key? key, this.token}) : super(key: key);

  // Set Variables
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
          appBar: widget.token == null ? BasicFormAppBar() : null,
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
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
                            Text(
                              'Create New Password',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: SimposiAppColors.simposiDarkGrey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Passwords must be at least 8 characters long.',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                      // RESET PASSWORD FORM
                      Container(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              // EMAIL FIELD
                              PasswordField(
                                  label: AppLocalizations.of(context)!
                                      .passwordChangePassword,
                                  controller: _passwordController,
                                  validator: getValidator(
                                      context, Validators.PASSWORD)),
                              SizedBox(height: 10),
                              // PASSWORD FIELD
                              PasswordField(
                                  label: AppLocalizations.of(context)!
                                      .passwordChangePasswordConfirm,
                                  controller: _confirmPasswordController,
                                  //TODO make validator smarter to assept additional causes
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .validatePasswordNotEmpty;
                                    } else if (value !=
                                        _passwordController.text) {
                                      return AppLocalizations.of(context)!
                                          .validatePasswordsDontMatch;
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(height: 10),
                              BlocConsumer<ResetPasswordCompleteCubit,
                                  ResetPasswordCompleteState>(
                                listener: (context, state) {
                                  if (state is ResetPasswordCompleteSuccess) {
                                    Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .passwordChangeSuccess,
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    if (state.pwdRestore)
                                      Navigator.of(context)
                                          .pushReplacementNamed('/login');
                                    else
                                      Navigator.of(context).pop();
                                  } else if (state
                                      is ResetPasswordCompleteError)
                                    Fluttertoast.showToast(
                                        msg: handleError(state.error, context),
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  else if (state is ResetPasswordStateError)
                                    Fluttertoast.showToast(
                                        msg: "Incorrect Application State",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                },
                                builder: (context, state) {
                                  if (state is ResetPasswordCompleteProgress) {
                                    return AppProgressIndicator();
                                  } else {
                                    return BigGBSelectButton(
                                        buttonLabel:
                                            AppLocalizations.of(context)!
                                                .passwordChangeSetNewPassword,
                                        buttonAction: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _autoValidate = true;
                                            print(
                                                'Password: ${_passwordController.text}');
                                            context
                                                .read<
                                                    ResetPasswordCompleteCubit>()
                                                .sendForgotPasswordComplete(
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    hash: widget.token);
                                          }
                                        });
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              // FORGOT PASSWORD BUTTON CONTAINED IN BOTTOM SHEET (NOT IN BUTTONS)
                              SimposiTextButton(
                                buttonLabel: 'Contact Support',
                                nextPage: '/profile',
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                onClick: () {},
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
          }),
        ),
      );
}
