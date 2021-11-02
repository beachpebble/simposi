/*
*  createevent1.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/datetimepicker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/formfields.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/event_photo_pick.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import '../app_router.dart';
import 'cubit/event_edit_cubit.dart';

class CreateEvent1 extends StatefulWidget {
  static const double progress = 0.16;

  @override
  State<CreateEvent1> createState() => _CreateEvent1State();
}

class _CreateEvent1State extends State<CreateEvent1> {
  final _formKey = GlobalKey<FormState>();
  String? _filePath;
  DateTime? _dateTime;
  DateTime? _dateTimeValue;
  late final TextEditingController _dateController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _dateTimeValue = DateTime.now().add(Duration(hours: 2));
    _dateController = TextEditingController()..addListener(() {setState(() {

    });});
    _titleController = TextEditingController()..addListener(() {setState(() {

    });});;
    _descriptionController = TextEditingController()..addListener(() {setState(() {

    });});;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
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
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Header
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(height: 45),
                              LinearProgressIndicator(
                                value: CreateEvent1.progress,
                                valueColor: AlwaysStoppedAnimation(
                                    SimposiAppColors.simposiDarkBlue),
                                backgroundColor:
                                    SimposiAppColors.simposiFadedBlue,
                              ),
                              const SizedBox(height: 70),
                              Text(
                                'Post an activity \nand start meeting new people.',
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              EventPhotoPick(
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
                        const SizedBox(height: 10),

                        // Body
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Column(
                              children: [
                                SimposiCounterField(
                                  inputType: TextInputType.text,
                                  fieldLabel: 'Title',
                                  counterLength: 60,
                                  fieldController: _titleController,
                                  validationLogic: (value) {
                                    if (value!.length < 4) {
                                      return 'Please enter a Title for your activity';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    _dateTimeValue = _dateTime ??
                                        DateTime.now().add(Duration(hours: 2));
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                        actions: [
                                          Container(
                                              height: 300,
                                              child: SimposiDateTimePicker(
                                                initial: _dateTime,
                                                callback: (dt) {
                                                  _dateTimeValue = dt;
                                                  ;
                                                },
                                              ))
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: Text('Save'),

                                          onPressed: () {
                                            _dateTime = _dateTimeValue;
                                            _dateController.text =
                                                DateFormat('yyyy-MM-dd – kk:mm')
                                                    .format(_dateTime!);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: AbsorbPointer(
                                    child: SimposiPlainField(
                                      inputType: TextInputType.datetime,
                                      fieldLabel: 'Date & Time',
                                      fieldController: _dateController,
                                      validationLogic: (value) {
                                        if (value!.length < 4) {
                                          return 'Please enter a Date & Time';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SimposiLargeTextField(
                                  fieldLabel: 'Description',
                                  textAreaLines: 10,
                                  fieldController: _descriptionController,
                                  validationLogic: (value) {
                                    if (value!.length < 4) {
                                      return 'Please enter a description';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                ContinueButton(
                                    buttonLabel: 'Submit',
                                    buttonAction: _nextEnabled()
                                        ? () {

                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_filePath?.isNotEmpty ==
                                                  true) {
                                                _formKey.currentState!.save();
                                                context
                                                    .read<EventEditCubit>()
                                                    .stage1(
                                                        title: _titleController
                                                            .text,
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        dateTime: _dateTime!,
                                                        file: _filePath!);
                                                AutoRouter.of(context)
                                                    .push(CreateEvent2Route());
                                              } else {
                                                showErrorToast("Add photo");
                                              }
                                            }
                                          }
                                        : null)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );

  bool _nextEnabled() {
    if (_titleController.text.length > 0 &&
        _descriptionController.text.length > 0 &&
        _dateController.text.length > 0) return true;
    return false;
  }
}
