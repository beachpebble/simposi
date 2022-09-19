/*
*  loginscreen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_start/forgot_password_start_cubit.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/forgot_password_button.dart';
import 'package:simposi_app_v4/global/widgets/phone_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

import '../../../app_router.dart';
import '../reset_password_start/forgotpasswordbottomsheet.dart';
import 'login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Set Variables
  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Set Variables
  String phone = '';
  String password = '';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

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
              authenticationBloc: context.read<AuthenticationBloc>(),
              profileRepository: context.read<ProfileRepository>()),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LOGO HEADER
                        SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/logo.png"),
                              Text(
                                AppLocalizations.of(context)!.loginTitle,
                                style: const TextStyle(
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // EMAIL FIELD
                              PhoneField(
                                controller: _phoneController,
                                onSave: (value) =>
                                    setState(() => phone = value),
                              ),
                              const SizedBox(height: 10),

                              // PASSWORD FIELD
                              _passwordField(),
                              const SizedBox(height: 10),
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginError) {
                                    showErrorToast(
                                        handleError(state.error, context));
                                  } else if (state is LoginUnconfirmed) {
                                    AutoRouter.of(context).push(
                                        SignUpForm8Route(
                                            validateParameters:
                                                ValidateParameters(phone)));
                                    // Navigator.of(context).pushNamed(
                                    //     '/signup8',
                                    //     arguments: ValidateParameters(
                                    //         phone));
                                  }
                                },
                                builder: (context, state) {
                                  return state is LoginProgress
                                      ? const AppProgressIndicator()
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
                                                    print('Phone: $phone');
                                                    print(
                                                        'Password: $password');
                                                    context
                                                        .read<LoginCubit>()
                                                        .login(phone, password);
                                                  }
                                                }
                                              : null);
                                },
                              ),
                              const SizedBox(height: 10),
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
                                        child: const ForgotPasswordForm(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Footer
                        SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .loginRegisterButton,
                                  style: const TextStyle(
                                    color: SimposiAppColors.simposiDarkBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () => {
                                  AutoRouter.of(context)
                                      .replace(const SignUpForm1Route())
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '© 2021 Simposi Inc.',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
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

        style: const TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          labelText: ' Password',
          contentPadding: const EdgeInsets.all(20),
          labelStyle: const TextStyle(
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
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightGrey,
            ),
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )),

          // ERROR STATE
          errorStyle: const TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: const OutlineInputBorder(
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
