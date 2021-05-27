/*
*  EditProfile.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import '../global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import '../global/routegenerator.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  // Set Variables
  String name = ' ';
  String phone = ' ';
  String email = ' ';
  String facebook = ' ';
  String instagram = ' ';
  String linkedin = ' ';
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

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // HEADER
                  Container(
                    height: 200,
                    color: SimposiAppColors.greyBackground,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        // TODO: ENABLE IMAGE PICKER & ERROR MESSAGE IF NO IMAGE ON SUBMIT
                        // TODO: ENSURE FIELDS ON THIS FORM RETAIN STATE/PREPOPULATE WITH USER DATA
                        //  PHOTO UPLOAD FIELD
                        AddPhotoButton(),
                        SizedBox(height: 10),
                        Text('Change Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // EDIT ACCOUNT FORM
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          // NAME FIELD
                          _nameField(),

                          // PHONE FIELD
                          _phoneField(),

                          // EMAIL FIELD
                          _emailField(),

                          // FACEBOOK FIELD
                          _facebookField(),

                          // INSTAGRAM FIELD
                          _instagramField(),

                          // LINKEDIN FIELD
                          _linkedinField(),


                        ],
                      ),
                    ),
                  ),


                  // FOOTER
                  Container(
                    height: 150,
                  ),

                ],
              ),
            );
          }
      ),
    ),
  );


  // NAME FIELD
  Widget _nameField() =>
      TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Name',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              ),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightText,
            )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiDarkBlue,
              ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _nameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _nameController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {
          if (value!.length < 4) {
            return 'Please enter your first name';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => name = value!),
      );


  // PHONE FIELD
  Widget _phoneField() =>
      TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiDarkBlue,
              )
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _phoneController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _phoneController.clear(),
          ),
        ),

        // PHONE VALIDATION LOGIC
        validator: (value) {

          // IF Empty
          if (value!.isEmpty) {
            return 'Phone Required';
          }
          if (value.length < 10) {
            return 'Must be at least 10 characters';
          }
          else {
            return null;
          }
        },

        // OUTPUT ACTIONS
        onSaved: (value) => setState(() => phone = value!),
      );


  // EMAIL FIELD
  Widget _emailField() =>
      TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Email',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightText,
            ),
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _emailController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _emailController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {

        },
        onSaved: (value) => setState(() => email = value!),
      );

  // FACEBOOK FIELD
  Widget _facebookField() =>
      TextFormField(
        controller: _facebookController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Facebook',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightText,
            ),
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _facebookController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _facebookController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {

        },
        onSaved: (value) => setState(() => facebook = value!),
      );


  // INSTAGRAM FIELD
  Widget _instagramField() =>
      TextFormField(
        controller: _instagramController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Instagram',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightText,
            ),
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _instagramController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _facebookController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {

        },
        onSaved: (value) => setState(() => instagram = value!),
      );


  // LINKEDIN FIELD
  Widget _linkedinField() =>
      TextFormField(
        controller: _linkedinController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: false,
        showCursor: true,

        style: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Linkedin',
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiDarkGrey,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          hintText: '',
          hintStyle: TextStyle(
            fontSize: 25,
          ),

          // INITIAL STATE
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightText,
            ),
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightText,
              )
          ),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // FOCUS ERROR STATE
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _linkedinController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _facebookController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {

        },
        onSaved: (value) => setState(() => linkedin = value!),
      );




}