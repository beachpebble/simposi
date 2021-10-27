/*
*  loginscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_start/forgot_password_start_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/forgot_password_button.dart';
import 'package:simposi_app_v4/global/widgets/phone_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

import '../reset_password_start/forgotpasswordbottomsheet.dart';
import 'login_cubit.dart';

class LoginScreen extends StatefulWidget {
  // Set Variables
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Set Variables
  String phone = '';
  String password = '';
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

  bool _nextEnabled() {
    return _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: BlocProvider(
          create: (context) => LoginCubit(
              authenticationBloc: context.read(),
              profileRepository: context.read()),
          child: Scaffold(
            backgroundColor: Colors.white,
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
                        // LOGO HEADER
                        Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/logo.png"),
                              Text(
                                AppLocalizations.of(context)!.loginTitle,
                                style: TextStyle(
                                  color: SimposiAppColors.simposiDarkBlue,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        // TODO: Validate Account Exists and Start a New Page Stack with Home (Tracy you need to learn how to reset the Page Stack instead of pushnamed)
                        // LOGIN FORM
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // EMAIL FIELD
                                PhoneField(
                                  controller: _phoneController,
                                  onSave: (value) =>
                                      setState(() => phone = value),
                                ),
                                SizedBox(height: 10),

                                // PASSWORD FIELD
                                _passwordField(),
                                SizedBox(height: 10),
                                BlocConsumer<LoginCubit, LoginState>(
                                  listener: (context, state) {
                                    if (state is LoginError) {
                                      showErrorToast(
                                          handleError(state.error, context));
                                    } else if (state is LoginUnconfirmed) {
                                      Navigator.of(context).pushNamed(
                                          '/signup8',
                                          arguments: ValidateParameters(
                                              phone));
                                    }
                                  },
                                  builder: (context, state) {
                                    return state is LoginProgress
                                        ? AppProgressIndicator()
                                        : ContinueButton(
                                            buttonLabel:
                                                AppLocalizations.of(context)!
                                                    .loginLogInButton,
                                            buttonAction: _nextEnabled()
                                                ? () {
                                                    final isValid = _formKey
                                                        .currentState!
                                                        .validate();

                                                    if (isValid) {
                                                      _formKey.currentState!
                                                          .save();
                                                      print('Phone: ${phone}');
                                                      print(
                                                          'Password: ${password}');
                                                      context
                                                          .read<LoginCubit>()
                                                          .login(
                                                              phone, password);
                                                    }
                                                  }
                                                : null);
                                  },
                                ),
                                SizedBox(height: 10),
                                ForgotPasswordTextButton(
                                  onClick: () {
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BlocProvider<
                                            ForgotPasswordStartCubit>(
                                          create: (context) =>
                                              ForgotPasswordStartCubit(
                                                  profileRepository:
                                                      context.read()),
                                          child: ForgotPasswordForm(),
                                        );
                                      },
                                    );
                                  },
                                ),
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
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .loginRegisterButton,
                                  style: TextStyle(
                                    color: SimposiAppColors.simposiDarkBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () => {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/signup1')
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
            }),
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
                  icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                      color: SimposiAppColors.simposiLightGrey),
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
        validator: getValidator(context, Validators.PASSWORD),
        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => password = value!),
      );
}
