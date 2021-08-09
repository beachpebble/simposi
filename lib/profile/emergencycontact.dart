/*
*  emergencycontact.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


class EmergencyContact extends StatefulWidget {
  // Set Variables
  @override
  _EmergencyContactState createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  // Set Variables
  String eContactName = ' ';
  String eContactPhone = ' ';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eContactNameController = TextEditingController();
  final TextEditingController _eContactPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eContactNameController.addListener(() => setState(() {}));
    _eContactPhoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _eContactNameController.dispose();
    _eContactPhoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      backgroundColor: Colors.white,

      appBar: BasicFormAppBar(),

      // TODO: Display BasicAppBar ONLY IF coming from ProfileMenu, else display none

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 20),
                            // TITLE
                            Text('Emergency Contact',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: SimposiAppColors.simposiDarkGrey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Simposi will only use this information if you get injured at a Simposi activity or are exposed to Covid at a Simposi activity. While we hope to never use this information, it is still best to supply one just in case.',
                              textAlign: TextAlign.center,),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),

                      // TODO: Enable Emergency Contact fields on User Profile
                      // FORM
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // EMERGENCY CONTACT NAME FIELD
                            _eContactNameField(),
                            SizedBox(height: 10),
                            // PASSWORD FIELD
                            _eContactPhoneField(),
                            SizedBox(height: 10),
                            BigGBSelectButton(
                                buttonLabel: 'Save',
                                buttonAction: () {
                                  final isValid = _formKey.currentState!
                                      .validate();

                                  if (isValid) {
                                    _formKey.currentState!.save();
                                    print('Password: ${eContactName}');
                                    print('Password: ${eContactPhone}');
                                    Navigator.of(context).pushReplacementNamed(
                                        '/home');
                                  }
                                }
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),

                      // FOOTER
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
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
          }
      ),
    ),
  );


  // EMERGENCY CONTACT NAME FIELD
  Widget _eContactNameField() =>
      TextFormField(
        controller: _eContactNameController,
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
          labelText: ' Name',
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiLightText,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),

          // Initial State
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiLightGrey,
            ),
          ),

          // Focus State
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiDarkBlue,
            ),
          ),

          // Focus Error State
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // Error State
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _eContactNameController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _eContactNameController.clear(),
          ),

        ),

        // Validation Logic
        validator: (value) {
          if (value!.length < 4) {
            return 'Please enter emergency contact name';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => eContactName = value!),
      );


  // EMERGENCY CONTACT PHONE FIELD
  Widget _eContactPhoneField() =>
      TextFormField(
        controller: _eContactPhoneController,
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
          labelText: ' Phone Number',
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(
            color: SimposiAppColors.simposiLightText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),

          // INITIAL STATE
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiLightGrey,
              )),

          // FOCUS STATE
          focusColor: SimposiAppColors.simposiDarkBlue,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiDarkBlue,
              )),

          // FOCUS ERROR STATE
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          // ERROR STATE
          errorStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(
                color: SimposiAppColors.simposiPink,
              )
          ),

          suffixIcon: _eContactPhoneController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.close,
                size: 20, color: SimposiAppColors.simposiLightGrey),
            onPressed: () => _eContactPhoneController.clear(),
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
        onSaved: (value) => setState(() => eContactPhone = value!),
      );


}