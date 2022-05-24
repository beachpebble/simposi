/*
*  resetpassword.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/password_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/global/widgets/resend_countdown.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

import 'reset_password_complete_cubit.dart';

/**
Use only for pwd change before login
 */
class ResetPasswordScreen extends StatefulWidget {
  final String phone;

  const ResetPasswordScreen({Key? key, required this.phone}) : super(key: key);
  // Set Variables
  @override
  State createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  bool _autoValidate = false;

  String code = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Timer? _timer;
  late AnimationController _controller;
  bool resendOnDelay = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    _startCountDownTimer();
  }

  void _startCountDownTimer() async {
    resendOnDelay = true;
    _controller.reset();
    _controller.forward();
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 60), () {
      setState(() {
        resendOnDelay = false;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  bool _nextEnabled() {
    return _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        code.length == 6;
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ResetPasswordCompleteCubit(
            profileRepository: context.read<ProfileRepository>(),
            phone: widget.phone),
        child: KeyboardDismisser(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
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
                        // HEADER LOGO
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/images/logo.png"),
                            const Text(
                              'simposi',
                              style: TextStyle(
                                color: SimposiAppColors.simposiDarkBlue,
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // TITLE
                            const Text(
                              'Create New Password',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: SimposiAppColors.simposiDarkGrey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Passwords must be at least 8 characters long.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),

                        // RESET PASSWORD FORM
                        Form(
                          key: _formKey,
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: PinCodeTextField(
                                  length: 6,
                                  backgroundColor: Colors.transparent,
                                  animationType: AnimationType.fade,
                                  animationDuration:
                                      const Duration(milliseconds: 200),
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 24),
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      fieldHeight: 50,
                                      fieldWidth:
                                          ((MediaQuery.of(context).size.width *
                                                      0.8) -
                                                  (5 * 7)) /
                                              6,
                                      borderRadius: BorderRadius.circular(25),
                                      borderWidth: 1,
                                      inactiveColor:
                                          SimposiAppColors.simposiLightGrey,
                                      selectedColor:
                                          SimposiAppColors.simposiDarkBlue,
                                      disabledColor:
                                          SimposiAppColors.simposiLightGrey,
                                      activeColor:
                                          SimposiAppColors.simposiDarkBlue),
                                  appContext: context,
                                  onChanged: (String value) {
                                    setState(() {
                                      code = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // EMAIL FIELD
                              PasswordField(
                                  label: AppLocalizations.of(context)!
                                      .passwordChangePassword,
                                  controller: _passwordController,
                                  validator: getValidator(
                                      context, Validators.PASSWORD)),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              BlocConsumer<ResetPasswordCompleteCubit,
                                  ResetPasswordCompleteState>(
                                listener: (context, state) {
                                  if (state is ResetPasswordCompleteSuccess) {
                                    showInfoToast(AppLocalizations.of(context)!
                                        .passwordChangeSuccess);
                                    Navigator.of(context).pop();
                                  } else if (state
                                      is ResetPasswordCompleteError) {
                                    showErrorToast(
                                        handleError(state.error, context));
                                  } else if (state
                                      is ResetPasswordResendError) {
                                    showErrorToast(
                                        handleError(state.error, context));
                                  } else if (state
                                      is ResetPasswordResendSuccess) {
                                    _startCountDownTimer();
                                    showInfoToast("Code was sent");
                                  } else if (state is ResetPasswordStateError) {
                                    showErrorToast(
                                        "Incorrect Application State");
                                  }
                                },
                                builder: (context, state) {
                                  if (state is ResetPasswordCompleteProgress) {
                                    return AppProgressIndicator();
                                  } else {
                                    return Column(
                                      children: [
                                        ContinueButton(
                                            buttonLabel: AppLocalizations.of(
                                                    context)!
                                                .passwordChangeSetNewPassword,
                                            buttonAction: _nextEnabled()
                                                ? () {
                                                    if (code.length == 6 &&
                                                        _formKey.currentState!
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
                                                              code: code);
                                                    }
                                                  }
                                                : null),
                                        const SizedBox(height: 15),
                                        resendOnDelay
                                            ? ResendCountDown(
                                                animation: StepTween(
                                                  begin: 60,
                                                  // THIS IS A USER ENTERED NUMBER
                                                  end: 0,
                                                ).animate(_controller),
                                              )
                                            : SimposiTextButton(
                                                buttonLabel:
                                                    'I never received a code',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                                onClick: () {
                                                  context
                                                      .read<
                                                          ResetPasswordCompleteCubit>()
                                                      .resend();
                                                },
                                              ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              // FORGOT PASSWORD BUTTON CONTAINED IN BOTTOM SHEET (NOT IN BUTTONS)
                              SimposiTextButton(
                                buttonLabel: 'Contact Support',
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                onClick: () {},
                              ),
                            ],
                          ),
                        ),

                        // FOOTER
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
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
