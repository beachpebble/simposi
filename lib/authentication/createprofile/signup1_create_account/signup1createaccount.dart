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
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
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

    context.read<RegistrationCubit>().reset();
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
                child: IntrinsicHeight(
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

                      return Container(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // HEADER
                            Container(
                              height: 225,
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
                                      setState(() {
                                        _filePath = val;
                                      });

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
                                    SizedBox(height: 10),

                                    // phone FIELD
                                    _phoneField(),
                                    SizedBox(height: 10),

                                    // phone FIELD
                                    _emailField(),
                                    SizedBox(height: 10),

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
                                      : ContinueButton(
                                      buttonLabel: 'Submit',
                                      buttonAction: _nextEnabled() ? () {
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
                                      } : null),
                                  SizedBox(height: 10),
                                  // TODO: Are we able to reuse this screen for edit profile? Change Button to just a save and hide footer?
                                  // LOGIN BUTTON
                                  SimposiTextButton(
                                    buttonLabel: "Log In",
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 30),
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

        decoration: InputDecoration(
          labelText: ' Name',

          suffixIcon: _nameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close,
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

        decoration: InputDecoration(
          labelText: ' Phone Number',

          suffixIcon: _phoneController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close,
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

  bool _nextEnabled() {
    return _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty && _emailController.text.isNotEmpty && _filePath != null && _filePath!.isNotEmpty;
  }

  Widget _emailField() => TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        decoration: InputDecoration(
          labelText: ' Email',

          suffixIcon: _emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close,
                      size: 20, color: SimposiAppColors.simposiLightGrey),
                  onPressed: () => _emailController.clear(),
                ),
        ),

        // PHONE VALIDATION LOGIC
        validator: getValidator(context, Validators.EMAIL),
      );
}
