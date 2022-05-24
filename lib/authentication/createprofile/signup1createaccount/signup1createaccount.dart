/*
*  signup1createaccount.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/profile_photo_pick_button.dart';
import 'package:simposi_app_v4/global/widgets/password_field.dart';
import 'package:simposi_app_v4/global/widgets/phone_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

import '../../../app_router.dart';
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
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  String _phone = "";

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _passwordConfirmController.addListener(() => setState(() {}));

    context.read<RegistrationCubit>().reset();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) => Signup1CreateAccountCubit(
            registrationCubit: context.read(),
            profileRepository: context.read()),
        child:       KeyboardDismisser(
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
                          AutoRouter.of(context)
                              .push(SignUpForm2Route());
                        } else if (state is Signup1CreateAccountError) {
                          showErrorToast(handleError(state.error, context));
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // HEADER
                              SizedBox(
                                height: 225,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Signup and start \n meeting new people.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: SimposiAppColors.simposiDarkGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // TODO: ENABLE IMAGE PICKER & ERROR MESSAGE IF NO IMAGE ON SUBMIT
                                    //  PHOTO UPLOAD FIELD
                                    ProfilePhotoPickButton(
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
                                      const SizedBox(height: 40),

                                      // NAME FIELD
                                      _nameField(),
                                      const SizedBox(height: 10),

                                      // phone FIELD
                                      PhoneField(
                                        onSave: (value) =>
                                            setState(() => _phone = value),
                                        controller: _phoneController,
                                      ),
                                      const SizedBox(height: 10),

                                      // email FIELD
                                      // PASSWORD FIELD
                                      PasswordField(
                                          label: AppLocalizations.of(context)!
                                              .signUpPassword,
                                          controller: _passwordController,
                                          validator: getValidator(
                                              context, Validators.PASSWORD)),
                                      const SizedBox(height: 10),

                                      // PASSWORD FIELD
                                      PasswordField(
                                          label: AppLocalizations.of(context)!
                                              .signUpPassword,
                                          controller: _passwordConfirmController,
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
                                      const SizedBox(height: 15),

                                      // SUBMIT BUTTON
                                      state is Signup1CreateAccountLoading
                                          ? AppProgressIndicator()
                                          : ContinueButton(
                                          buttonLabel: 'Submit',
                                          buttonAction: _nextEnabled()
                                              ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_filePath
                                                  ?.isNotEmpty ==
                                                  true) {
                                                _formKey.currentState!
                                                    .save();
                                                context
                                                    .read<
                                                    Signup1CreateAccountCubit>()
                                                    .firstStage(
                                                    name:
                                                    _nameController
                                                        .text,
                                                    password:
                                                    _passwordController
                                                        .text,
                                                    file:
                                                    _filePath!,
                                                    phone: _phone);
                                              } else {
                                                showErrorToast(
                                                    "Add photo");
                                              }
                                            }
                                          }
                                              : null),
                                      const SizedBox(height: 10),
                                      // LOGIN BUTTON
                                      SimposiTextButton(
                                        buttonLabel: "Log In",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        onClick: () {
                                          AutoRouter.of(context).replace(const LoginScreenRoute());
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
                                  children: const [
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

  bool _nextEnabled() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty &&
        _filePath != null &&
        _filePath!.isNotEmpty;
  }
}
