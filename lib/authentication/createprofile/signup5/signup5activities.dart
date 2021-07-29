/*
*  signup5activities.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/model/interest.dart';

import 'signup5_activities_cubit.dart';

class SignUpForm5 extends StatefulWidget {
  @override
  _SignUpForm5State createState() => _SignUpForm5State();
}

class _SignUpForm5State extends State<SignUpForm5> {
  // Set Variables
  double progress = 0.70;

  // FOR EACH ACTIVITY CREATE AN ACTIVITY BUTTON
  List<Widget> selectedActivityWidgets(Set<Interest> interests,
      Set<Interest> selectedItems, BuildContext context) {
    return interests
        .map((item) => SelectableChip(
            selected: selectedItems.contains(item),
            title: item.title,
            onClick: (value) {
              value
                  ? context.read<Signup6ActivitiesCubit>().selectInterest(item)
                  : context
                      .read<Signup6ActivitiesCubit>()
                      .deselectInterest(item);
            }))
        .toList();
  }

  // SIGNUP FORM PAGE 6 LAYOUT
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => Signup6ActivitiesCubit(
          context.read<AuthenticationBloc>().masterData.interests),
      child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: BasicFormAppBar(),
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child:
                    BlocBuilder<Signup6ActivitiesCubit, Signup6ActivitiesState>(
                  buildWhen: (prev, current) {
                    return prev.filtered != current.filtered ||
                        prev.nextEnabled != current.nextEnabled;
                  },
                  builder: (context, state) {
                    return Column(
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

                        SizedBox(height: 70),

                        Container(
                          child: Column(
                            children: [
                              // Header
                              Text(
                                'I like to ...',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: SimposiAppColors.simposiDarkGrey,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Choose as many interests as you like.',
                                style: TextStyle(
                                  color: SimposiAppColors.simposiLightText,
                                  fontSize: 13,
                                ),
                              ),
                              _searchBar(context),
                              // TAG CLOUD
                              Container(
                                child: Wrap(
                                  runSpacing: -8.0,
                                  children: selectedActivityWidgets(
                                      state.filtered, state.selected, context),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Continue Button
                        Container(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            children: [
                              ContinueButton(
                                buttonAction: state.nextEnabled
                                    ? () {
                                        context
                                            .read<RegistrationCubit>()
                                            .stage5(interests: state.selected);
                                        Navigator.of(context)
                                            .pushNamed('/signup7');
                                      }
                                    : null,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          })));

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          hintText: 'Search activity',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) =>
            context.read<Signup6ActivitiesCubit>().search(value),
      ),
    );
  }
}

/**
 * We need to make separate stateful to improve perfomance
 */
class SelectableChip extends StatefulWidget {
  final String title;
  final Function(bool) onClick;
  final bool selected;

  const SelectableChip(
      {Key? key,
      required this.title,
      required this.onClick,
      this.selected = false})
      : super(key: key);

  @override
  _SelectableChipState createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool? selected;

  bool get realSelected => selected ?? widget.selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InputChip(
        label: Text(
          widget.title,
          style: TextStyle(color: realSelected ? Colors.white : Colors.black),
        ),
        elevation: 0,
        showCheckmark: false,
        selectedColor: SimposiAppColors.simposiDarkBlue,
        selected: realSelected,
        onSelected: (bool value) {
          setState(() {
            selected = value;
            widget.onClick(value);
          });
        },
      ),
    );
  }
}
