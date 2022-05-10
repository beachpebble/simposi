/*
*  signup7covid.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import '../../app_router.dart';

class SignUpForm7 extends StatefulWidget {
  @override
  _SignUpForm7State createState() => _SignUpForm7State();
}

class _SignUpForm7State extends State<SignUpForm7> {
  double progress = 1.0;

  bool _agreement0 = false;
  bool _agreement1 = false;
  bool _agreement2 = false;
  bool _agreement3 = false;
  bool _agreement4 = false;
  bool _agreement5 = false;

  @override
  void initState() {
    super.initState();
    _agreement0 = context.read<RegistrationCubit>().stage8Agree[0];
    _agreement1 = context.read<RegistrationCubit>().stage8Agree[1];
    _agreement2 = context.read<RegistrationCubit>().stage8Agree[2];
    _agreement3 = context.read<RegistrationCubit>().stage8Agree[3];
    _agreement4 = context.read<RegistrationCubit>().stage8Agree[4];
    _agreement5 = context.read<RegistrationCubit>().stage8Agree[5];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                // Header
                Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      LinearProgressIndicator(
                        value: progress,
                        valueColor: const AlwaysStoppedAnimation(
                            SimposiAppColors.simposiDarkBlue),
                        backgroundColor: SimposiAppColors.simposiFadedBlue,
                      ),
                      const SizedBox(height: 70),
                      Text(
                        'Health & Safety Agreement',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: Text(
                          'You must agree to follow the CDC guidelines \n and local regulations to use Simposi.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        children: <Widget>[
                          Wrap(
                            children: [
                              _getAgreeItem(
                                  title:
                                      'I have read & understand my local regulations and the CDC Guidelines.',
                                  agree: _agreement0,
                                  onClick: () {
                                    setState(() {
                                      _agreement0 = !_agreement0;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 0, agreeVal: _agreement0);
                                  }),
                              _getAgreeItem(
                                  title:
                                      'I will stay home if I have a cough or fever or am just not feeling well.',
                                  agree: _agreement1,
                                  onClick: () {
                                    setState(() {
                                      _agreement1 = !_agreement1;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 1, agreeVal: _agreement1);
                                  }),
                              _getAgreeItem(
                                  title:
                                      'I will carry a face mask at all times and wear it is as required by the activity hosts, the CDC and/or local guidelines.',
                                  agree: _agreement2,
                                  onClick: () {
                                    setState(() {
                                      _agreement2 = !_agreement2;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 2, agreeVal: _agreement2);
                                  }),
                              _getAgreeItem(
                                  title:
                                      'I will maintain a safe social distance while attending Simposi activities.',
                                  agree: _agreement3,
                                  onClick: () {
                                    setState(() {
                                      _agreement3 = !_agreement3;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 3, agreeVal: _agreement3);
                                  }),
                              _getAgreeItem(
                                  title:
                                      'I will wash and/or sanitize my hands as frequently as possible while attending a Simposi activity.',
                                  agree: _agreement4,
                                  onClick: () {
                                    setState(() {
                                      _agreement4 = !_agreement4;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 4, agreeVal: _agreement4);
                                  }),
                              _getAgreeItem(
                                  title:
                                      'I will notify Simposi immediately if I test positive for Covid-19 after attending an activity.',
                                  agree: _agreement5,
                                  onClick: () {
                                    setState(() {
                                      _agreement5 = !_agreement5;
                                    });
                                    context
                                        .read<RegistrationCubit>()
                                        .covidAgree(
                                            agreeNum: 5, agreeVal: _agreement5);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 00, 40, 40),
                  color: Colors.white,
                  child: Column(
                    children: [
                      BlocListener<RegistrationCubit, RegistrationState>(
                        listener: (context, state) {
                          if (state is RegistrationWaitCode)
                            AutoRouter.of(context).replaceAll([
                              SignUpForm8Route(
                                  validateParameters:
                                      ValidateParameters(state.phone))
                            ]);
                          else if (state is RegistrationError) {
                            showErrorToast(handleError(state.error, context));
                          }
                        },
                        child: ContinueButton(
                          buttonLabel: 'Finish',
                          buttonAction: _isFinishEnabled()
                              ? () => context.read<RegistrationCubit>().finish()
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
      _agreement0;

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
            const SizedBox(height: 10),
            const Divider(
              color: SimposiAppColors.simposiLightText,
            ),
          ],
        ),
      ),
    );
  }
}
