/*
*  EditProfile.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/formfields.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/add_photo_button.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/profile/bloc/profile_edit_cubit.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/utils/validators.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _filePath;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = context.read<ProfileEditCubit>().profile.userName;
    _phoneController.text = context.read<ProfileEditCubit>().profile.userPhone;
    _emailController.text = context.read<ProfileEditCubit>().profile.userEmail;
    _facebookController.text =
        context.read<ProfileEditCubit>().profile.facebook ?? "";
    _instagramController.text =
        context.read<ProfileEditCubit>().profile.instagram ?? "";
    _linkedinController.text =
        context.read<ProfileEditCubit>().profile.linkedin ?? "";

    _phoneController.text = context.read<ProfileEditCubit>().profile.userPhone;
    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _facebookController.addListener(() => setState(() {}));
    _instagramController.addListener(() => setState(() {}));
    _linkedinController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BasicFormAppBar(),
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              child: Column(
                children: [
                  // HEADER
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Account Settings',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 10),
                        // TODO: ENSURE FIELDS ON THIS FORM RETAIN STATE/PREPOPULATE WITH USER DATA
                        //  PHOTO UPLOAD FIELD
                        AddPhotoButton(
                          initialImage: context
                              .read<ProfileEditCubit>()
                              .profile
                              .profilePhoto,
                          imageSelectCallback: (val) {
                            print("selected image $val");
                            _filePath = val;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Change Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Form(
                        key: _formKey,
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
                                  Container(
                                    child: Column(
                                      children: [
                                        SimposiFormFieldwClear(
                                          inputType: 'name',
                                          fieldLabel: ' Name',
                                          fieldController: _nameController,
                                          validationLogic: getValidator(
                                              context, Validators.NAME),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        SimposiFormFieldwClear(
                                          inputType: 'phone',
                                          fieldLabel: ' Phone',
                                          fieldController: _phoneController,
                                          validationLogic: getValidator(
                                              context, Validators.PHONE),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        SimposiFormFieldwClear(
                                          inputType: 'url',
                                          fieldLabel: ' Facebook',
                                          fieldController: _facebookController,
                                          validationLogic: getValidator(
                                              context, Validators.URL_LINK),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        SimposiFormFieldwClear(
                                          inputType: 'url',
                                          fieldLabel: ' Instagram',
                                          fieldController: _instagramController,
                                          validationLogic: getValidator(
                                              context, Validators.URL_LINK),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        SimposiFormFieldwClear(
                                          inputType: 'url',
                                          fieldLabel: ' Linkedin',
                                          fieldController: _linkedinController,
                                          validationLogic: getValidator(
                                              context, Validators.URL_LINK),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // FOOTER
                  Container(
                    child: SafeArea(
                      child: BlocConsumer<ProfileEditCubit, ProfileEditState>(
                        listener: (context, state) {
                          if (state is ProfileEditError) {
                            showErrorToast(handleError(state.error, context));
                          } else if (state is ProfileEditSuccess) {
                            showInfoToast("Profile is updated");
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          return state is ProfileEditLoading
                              ? Center(child: AppProgressIndicator())
                              : ContinueButton(
                                  buttonLabel: 'Save',
                                  buttonAction: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ProfileEditCubit>()
                                          .updateMainFields(
                                              name: _nameController.text,
                                              phone: _phoneController.text,
                                              facebook: _facebookController.text,
                                              instagram:
                                                  _instagramController.text,
                                              linkedin: _linkedinController.text,
                                              filePath: _filePath);
                                    }
                                  });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
}
