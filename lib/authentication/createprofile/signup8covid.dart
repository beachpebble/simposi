/*
*  signup8covid.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup9/signup9_validate_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

class SignUpForm8 extends StatefulWidget {
  @override
  _SignUpForm8State createState() => _SignUpForm8State();
}

class _SignUpForm8State extends State<SignUpForm8> {
  double progress = 0.88;

  bool _agreement1 = false;
  bool _agreement2 = false;
  bool _agreement3 = false;
  bool _agreement4 = false;
  bool _agreement5 = false;
  bool _agreement6 = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                SizedBox(height: 45),
                Container(
                  child: LinearProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation(
                        SimposiAppColors.simposiDarkBlue),
                    backgroundColor: SimposiAppColors.simposiFadedBlue,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      // Header Title
                      Text(
                        'Health and Safety Agreement',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: SimposiAppColors.simposiDarkGrey,
                        ),
                      ),
                      SizedBox(height: 20),

                      Text(
                        'You must agree to follow the CDC guidelines \n and your local regulations to use Simposi.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      _getAgreeItem(
                          title:
                              'I have read & understand my local regulations and the CDC Guidelines.',
                          agree: _agreement1,
                          onClick: () {
                            setState(() {
                              _agreement1 = !_agreement1;
                            });
                          }),
                      _getAgreeItem(
                          title:
                              'I will stay home if I have a cough or fever or am just not feeling well.',
                          agree: _agreement2,
                          onClick: () {
                            setState(() {
                              _agreement2 = !_agreement2;
                            });
                          }),
                      _getAgreeItem(
                          title:
                              'I will carry a face mask at all times and wear it is as required by the activity hosts, the CDC and/or local guidelines.',
                          agree: _agreement3,
                          onClick: () {
                            setState(() {
                              _agreement3 = !_agreement3;
                            });
                          }),
                      _getAgreeItem(
                          title:
                              'I will maintain a safe social distance while attending Simposi activities.',
                          agree: _agreement4,
                          onClick: () {
                            setState(() {
                              _agreement4 = !_agreement4;
                            });
                          }),
                      _getAgreeItem(
                          title:
                              'I will wash and/or sanitize my hands as frequently as possible while attending a Simposi activity.',
                          agree: _agreement5,
                          onClick: () {
                            setState(() {
                              _agreement5 = !_agreement5;
                            });
                          }),
                      _getAgreeItem(
                          title:
                              'I will notify Simposi immediately if I test positive for Covid-19 after attending an activity.',
                          agree: _agreement6,
                          onClick: () {
                            setState(() {
                              _agreement6 = !_agreement6;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 60),
                  child: Column(
                    children: [
                      BlocListener<RegistrationCubit, RegistrationState>(
                        listener: (context, state) {
                          if (state is RegistrationWaitCode)
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/signup9', ModalRoute.withName('start'),
                                arguments: ValidateParameters(state.phone, state.token));
                          else if (state is RegistrationError) {
                            showErrorToast(handleError(state.error, context));
                          }
                        },
                        child: ContinueButton(
                          buttonLabel: 'Finish',
                          buttonAction: _isFinishEnabled()
                              ? () =>
                                  {context.read<RegistrationCubit>().finish()}
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }));

  bool _isFinishEnabled() =>
      _agreement1 &&
      _agreement2 &&
      _agreement3 &&
      _agreement4 &&
      _agreement5 &&
      _agreement6;

  Widget _getAgreeItem(
      {required String title,
      required bool agree,
      required VoidCallback onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        child: Column(
          children: [
            Row(children: [
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                ),
              ),
              AgreeButton(
                agree: agree,
                onClick: onClick,
              ),
            ]),
            SizedBox(height: 10),
            Divider(
              color: SimposiAppColors.simposiLightText,
            ),
          ],
        ),
      ),
    );
  }
}
