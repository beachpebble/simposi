/*
*  change_password_screen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/authentication/login/change_password/change_password_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';
import 'package:simposi_app_v4/global/widgets/password_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';

/**
 * Use only for password change from settings
 */
class ChangePasswordScreen extends StatefulWidget {
  // Set Variables
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _confirmPasswordController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ChangePasswordCubit(
            profileRepository: context.read(), authRepository: context.read()),
        child: KeyboardDismisser(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: BasicFormAppBar(),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        // HEADER LOGO
                        Container(
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
                        Form(
                          key: _formKey,
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
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
                              BlocConsumer<ChangePasswordCubit,
                                  ChangePasswordState>(
                                listener: (context, state) {
                                  if (state is ChangePasswordSuccess) {
                                    showInfoToast(
                                        AppLocalizations.of(context)!
                                            .passwordChangeSuccess);
                                    Navigator.of(context).pop();
                                  } else if (state is ChangePasswordError)
                                    showErrorToast(
                                        handleError(state.error, context));
                                },
                                builder: (context, state) {
                                  if (state is ChangePasswordLoading) {
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
                                            context
                                                .read<ChangePasswordCubit>()
                                                .changePassword(
                                                    _passwordController.text);
                                          }
                                        });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        // FOOTER
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 20),
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
        ),
      );
}
