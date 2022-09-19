/*
*  emergency_contact_screen.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/phone_field.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({super.key});

  // Set Variables
  @override
  State createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  // Set Variables
  String eContactName = ' ';
  String eContactPhone = ' ';
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _eContactNameController;
  late final TextEditingController _eContactPhoneController;

  @override
  void initState() {
    super.initState();
    _eContactNameController = TextEditingController(
        text: context.read<ProfileRepository>().profile.emergencyContactName ??
            "")
      ..addListener(() => setState(() {}));
    _eContactPhoneController = TextEditingController()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _eContactNameController.dispose();
    _eContactPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicFormAppBar(),
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
                  children: [
                    // HEADER
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SizedBox(height: 20),
                        // TITLE
                        Text(
                          'Emergency Contact',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: SimposiAppColors.simposiDarkGrey,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Simposi will only use this information if you get injured at a Simposi activity or are exposed to Covid at a Simposi activity. While we hope to never use this information, it is still best to supply one just in case.',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25),
                      ],
                    ),

                    // TODO: Enable Emergency Contact fields on User Profile
                    // FORM
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // EMERGENCY CONTACT NAME FIELD
                          _eContactNameField(),
                          const SizedBox(height: 10),
                          // PASSWORD FIELD
                          PhoneField(
                            initialPhone: context
                                    .read<ProfileRepository>()
                                    .profile
                                    .emergencyContactPhone ??
                                "",
                            onSave: (value) =>
                                setState(() => eContactPhone = value),
                            controller: _eContactPhoneController,
                          ),
                          const SizedBox(height: 10),
                          BlocConsumer<ProfileBloc, ProfileState>(
                            listener: (context, state) {
                              if (state is ProfileEditError) {
                                showErrorToast(
                                    handleError(state.error, context));
                              } else if (state is ProfileEditSuccess) {
                                showInfoToast("emergency Contact is updated");
                                Navigator.of(context).pop();
                              }
                            },
                            builder: (context, state) {
                              return state is ProfileEditLoading
                                  ? const Center(child: AppProgressIndicator())
                                  : ContinueButton(
                                      buttonLabel: 'Save',
                                      buttonAction: _nextEnabled()
                                          ? () {
                                              final isValid = _formKey
                                                  .currentState!
                                                  .validate();

                                              if (isValid) {
                                                _formKey.currentState!.save();

                                                context.read<ProfileBloc>().add(
                                                    ProfileUpdateEmergencyContact(
                                                        name: eContactPhone,
                                                        phone: eContactPhone));
                                              }
                                            }
                                          : null);
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // FOOTER
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
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
      );

  bool _nextEnabled() {
    return _eContactNameController.text.isNotEmpty &&
        _eContactPhoneController.text.isNotEmpty;
  }

  // EMERGENCY CONTACT NAME FIELD
  Widget _eContactNameField() => TextFormField(
        controller: _eContactNameController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: const TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          labelText: ' Name',
          contentPadding: const EdgeInsets.all(20),
          labelStyle: const TextStyle(
            color: SimposiAppColors.simposiLightText,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),

          // Initial State
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightGrey,
            ),
          ),

          // Focus State
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // Focus Error State
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )),

          // Error State
          errorStyle: const TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )),

          suffixIcon: _eContactNameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.close,
                      size: 20, color: SimposiAppColors.simposiLightGrey),
                  onPressed: () => _eContactNameController.clear(),
                ),
        ),

        // Validation Logic
        validator: getValidator(context, Validators.NAME),
        onSaved: (value) => setState(() => eContactName = value!),
      );
}
