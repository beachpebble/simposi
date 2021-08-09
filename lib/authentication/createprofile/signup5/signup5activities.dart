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

class SignUpForm5 extends StatelessWidget {

  final double progress = 0.66;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: LayoutBuilder(builder:
          (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          child: ConstrainedBox(
            constraints:BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child:
            BlocBuilder<Signup5ActivitiesCubit, Signup5ActivitiesState>(
              buildWhen: (prev, current) {
                return prev.filtered != current.filtered ||
                    prev.nextEnabled != current.nextEnabled;
              },
              builder: (context, state) {
                return Column(
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
                            'I like to ...',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: _searchBar(context),
                          ),
                        ],
                      ),
                    ),

                    // Body 
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            primary: true,
                            shrinkWrap: true,
                            children: <Widget>[
                              Wrap(
                              runSpacing: -8.0,
                              children: selectedActivityWidgets(
                                  state.filtered, state.selected, context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Footer
                    Container(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ContinueButton(
                            buttonAction: state.nextEnabled
                                ? () {
                              Navigator.of(context)
                                  .pushNamed('/signup6');
                            }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }));

  // FOR EACH ACTIVITY CREATE AN ACTIVITY BUTTON
  List<Widget> selectedActivityWidgets(Set<Interest> interests,
      Set<Interest> selectedItems, BuildContext context) {
    return interests
        .map((item) => SelectableChip(
        key: ValueKey(item.id),
        selected: selectedItems.contains(item),
        title: item.title,
        onClick: (value) {
          value
              ? context.read<Signup5ActivitiesCubit>().selectInterest(item)
              : context
              .read<Signup5ActivitiesCubit>()
              .deselectInterest(item);
        }))
        .toList();
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          hintText: 'Search activity',
          suffixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) =>
            context.read<Signup5ActivitiesCubit>().search(value),
      ),
    );
  }
}


/**
 * We need to make separate stateful to improve performance
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
