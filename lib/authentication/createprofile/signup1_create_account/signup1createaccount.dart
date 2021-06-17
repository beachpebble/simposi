/*
*  signup1createaccount.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';
import 'package:simposi_app_v4/widgets/add_photo_button.dart';
import 'package:simposi_app_v4/widgets/password_field.dart';
import 'package:simposi_app_v4/widgets/progress.dart';

import '../../../global/theme/elements/simposibuttons.dart';
import '../../authenticationwidgets/privacytoufooter.dart';
import 'signup1_create_account_cubit.dart';

class SignUpForm1 extends StatefulWidget {
  @override
  _SignUpForm1State createState() => _SignUpForm1State();
}

class _SignUpForm1State extends State<SignUpForm1> {
  final _formKey = GlobalKey<FormState>();
  String? _filePath;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: BlocConsumer<Signup1CreateAccountCubit,
                    Signup1CreateAccountState>(
                  listener: (context, state) {
                    if (state is Signup1CreateAccountReady) {
                      Navigator.of(context).pushNamed('/signup2');
                    } else if (state is Signup1CreateAccountError) {
                      showErrorToast(handleError(state.error, context));
                    }
                  },
                  builder: (context, state) {
                    if (state is Signup1CreateAccountLoadingData)
                      return Center(child: AppProgressIndicator());
                    else if (state is Signup1CreateAccountLoadingDataError)
                      return Center(
                        child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              Text(
                                  "error loading master data ${handleError(state.error, context)}"),
                              SizedBox(height: 20),
                              SizedBox(
                                width: 150,
                                child: BigGBSelectButton(
                                    buttonLabel: 'Retry',
                                    buttonAction: () {
                                      context
                                          .read<Signup1CreateAccountCubit>()
                                          .preload();
                                    }),
                              )
                            ],
                          ),
                        ),
                      );
                    else
                      return Container(
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
                                  AddPhotoButton(
                                    imageSelectCallback: (val) {
                                      print("selected image $val");
                                      _filePath = val;
                                    },
                                  ),
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

                                    // phone FIELD
                                    _phoneField(),
                                    SizedBox(height: 15),

                                    // phone FIELD
                                    _emailField(),
                                    SizedBox(height: 15),

                                    // PASSWORD FIELD
                                    PasswordField(
                                        label: AppLocalizations.of(context)!
                                            .signUpPassword,
                                        controller: _passwordController,
                                        validator: getValidator(
                                            context, Validators.PASSWORD)),
                                    SizedBox(height: 15),

                                    // SUBMIT BUTTON
                                    state is Signup1CreateAccountLoading
                                        ? AppProgressIndicator()
                                        : BigGBSelectButton(
                                            buttonLabel: 'Submit',
                                            buttonAction: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // Navigator.of(context)
                                                //     .pushNamed('/signup2');
                                                if (_filePath?.isNotEmpty ==
                                                    true) {
                                                  context
                                                      .read<
                                                          Signup1CreateAccountCubit>()
                                                      .firstStage(
                                                          name: _nameController
                                                              .text,
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          password:
                                                              _passwordController
                                                                  .text,
                                                          file: _filePath!,
                                                          phone:
                                                              _phoneController
                                                                  .text);
                                                } else {
                                                  showErrorToast("Add photo");
                                                }
                                              }
                                            }),
                                    SizedBox(height: 10),
                                    // TODO: Are we able to reuse this screen for edit profile? Change Button to just a save and hide footer?
                                    // LOGIN BUTTON
                                    SimposiTextButton(
                                      buttonLabel: "Log In",
                                      nextPage: '/login',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      onClick: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/login');
                                      },
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
                                    footerColor:
                                        SimposiAppColors.simposiLightText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                  },
                ),
              ),
            );
          }),
        ),
      );

  // NAME FIELD
  Widget _nameField() => TextFormField(
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
              )),

          // Error State
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )),

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
      );

  // PHONE FIELD
  Widget _phoneField() => TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
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
          labelText: ' Phone Number',
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

          suffixIcon: _phoneController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close,
                      size: 20, color: SimposiAppColors.simposiLightGrey),
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
          } else {
            return null;
          }
        },
      );

  Widget _emailField() => TextFormField(
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
          labelText: ' Email',
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

          suffixIcon: _emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close,
                      size: 20, color: SimposiAppColors.simposiLightGrey),
                  onPressed: () => _emailController.clear(),
                ),
        ),

        // PHONE VALIDATION LOGIC
        validator: getValidator(context, Validators.EMAIL),
      );
}
