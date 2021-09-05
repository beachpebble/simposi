/*
*  signup8validate.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/widgets/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/global/widgets/resend_countdown.dart';

import 'signup8_validate_cubit.dart';

class SignUpForm8 extends StatefulWidget {
  @override
  _SignUpForm8State createState() => _SignUpForm8State();
}

class _SignUpForm8State extends State<SignUpForm8> with TickerProviderStateMixin {
  String code = "";

  Timer? _timer;
  late AnimationController _controller;
  bool resendOnDelay = false;


  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    _startCountDownTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  _startCountDownTimer() async {
    resendOnDelay = true;
    _controller.reset();
    _controller.forward();
    _timer?.cancel();
    _timer = new Timer(new Duration(seconds: 60), () {
      setState(() {
        resendOnDelay = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BasicFormAppBar(),
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
                    children: [
                      // HEADER
                      Container(
                        alignment: Alignment.center,
                        child: Column(
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
                          ],
                        ),
                      ),

                      // Body
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Account Created',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Check your email for an access code \n to activate your account.',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),

                            // PIN CODE FIELDS
                            Container(
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

                            SizedBox(height: 25),
                            BlocConsumer<Signup8ValidateCubit,
                                Signup8ValidateState>(
                              listener: (context, state) {
                                if (state is Signup8ValidateSuccess) {
                                  print("Success Signup8ValidateSuccess");
                                  if (state.message.isNotEmpty)
                                    showInfoToast(state.message);
                                } else if (state is Signup8ValidateError) {
                                  showErrorToast(
                                      handleError(state.error, context));
                                } else if (state is Signup8ResendSuccess) {
                                  _startCountDownTimer();
                                  showInfoToast(
                                      "Code was resent");
                                }
                              },
                              builder: (context, state) {
                                return state is Signup8ValidateLoading
                                    ? AppProgressIndicator()
                                    : Column(
                                        children: [
                                          ContinueButton(
                                            buttonLabel: 'Verify',
                                            buttonAction: code.length == 6
                                                ? () {
                                                    context
                                                        .read<
                                                            Signup8ValidateCubit>()
                                                        .validate(code);
                                                  }
                                                : null,
                                          ),
                                          SizedBox(height: 15),
                                          resendOnDelay
                                              ? ResendCountDown(
                                            animation: StepTween(
                                              begin: 60,
                                              // THIS IS A USER ENTERED NUMBER
                                              end: 0,
                                            ).animate(_controller),
                                          )
                                              :SimposiTextButton(
                                            buttonLabel:
                                                'I never received a code',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            onClick: () {
                                              context
                                                  .read<Signup8ValidateCubit>()
                                                  .resend();
                                            },
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Footer
                      Container(
                        child: Column(
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
