/*
*  signup9validate.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/widgets/progress.dart';

import 'signup9_validate_cubit.dart';

class SignUpForm9 extends StatefulWidget {
  @override
  _SignUpForm9State createState() => _SignUpForm9State();
}

class _SignUpForm9State extends State<SignUpForm9> {
  String code = "";

  // @override
  // void initState() {
  //   _pinController = TextEditingController();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _pinController?.dispose();
  //   super.dispose();
  // }

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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      // FORM
                      Container(
                        child: Column(
                          children: [
                            // TITLE
                            Text(
                              'Account Created',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: SimposiAppColors.simposiDarkGrey,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Check your email for an access code \n to activate your account.',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 25),

                            // TODO: Enable These
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
                            BlocConsumer<Signup9ValidateCubit,
                                Signup9ValidateState>(
                              listener: (context, state) {
                                if (state is Signup9ValidateSuccess) {
                                  print("Success Signup9ValidateSuccess");
                                  if (state.message.isNotEmpty)
                                    showInfoToast(state.message);
                                } else if (state is Signup9ValidateError) {
                                  showErrorToast(
                                      handleError(state.error, context));
                                }
                              },
                              builder: (context, state) {
                                return state is Signup9ValidateLoading
                                    ? AppProgressIndicator()
                                    : BigGBSelectButton(
                                        buttonLabel: 'Verify',
                                        buttonAction: code.length == 6
                                            ? () => {
                                                  context
                                                      .read<
                                                          Signup9ValidateCubit>()
                                                      .validate(code)
                                                }
                                            : null,
                                      );
                              },
                            ),
                            SizedBox(height: 15),
                            SimposiTextButton(
                              buttonLabel: 'I never received a code',
                              nextPage: '/home',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              onClick: () {},
                            ),

                            SizedBox(height: 10),

                            // TODO: Enable Resend Code Timer
                            Text(
                              'Resend in 3s',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

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
