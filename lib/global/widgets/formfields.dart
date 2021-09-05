/*
*  formfields.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TEXT FIELD WITH CLEAR FUNCTION
class SimposiFormFieldwClear extends StatelessWidget {
  final String inputType;
  final String fieldLabel;
  final validationLogic;
  final TextEditingController fieldController;

  const SimposiFormFieldwClear({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.validationLogic,
    required this.fieldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,

      decoration: InputDecoration(
        labelText: fieldLabel,

        suffixIcon: fieldController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close,
                    size: 20, color: SimposiAppColors.simposiLightGrey),
                onPressed: () => fieldController.clear(),
              ),
      ),
      validator: validationLogic,
    );
  }
}

// PASSWORD FIELD
class SimposiPasswordField extends StatefulWidget {
  const SimposiPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  _SimposiPasswordFieldState createState() => _SimposiPasswordFieldState();
}

class _SimposiPasswordFieldState extends State<SimposiPasswordField> {
  String _password = ' ';
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: _passwordVisible,
      showCursor: true,

      decoration: InputDecoration(
        labelText: ' Password',

        suffixIcon: _passwordController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: SimposiAppColors.simposiLightGrey),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                }),
      ),

      // VALIDATION LOGIC
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password Required';
        }
        if (value.length < 8) {
          return 'Must be at least 8 characters';
        } else {
          return null;
        }
      },

      // OUTPUT ACTIONS
      onSaved: (value) => setState(() => _password = value!),
    );
  }
}


// TEXT FIELD WITH COUNTER
class SimposiCounterField extends StatefulWidget {
  final TextInputType inputType;
  final String fieldLabel;
  final int counterLength;
  var textLength = 0;
  final validationLogic;

  SimposiCounterField({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.counterLength,
    required this.validationLogic,
  }) : super(key: key);

  @override
  _SimposiCounterFieldState createState() => _SimposiCounterFieldState();
}

class _SimposiCounterFieldState extends State<SimposiCounterField> {
  String _input = ' ';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _fieldController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,
      maxLength: widget.counterLength,

      style: TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        labelText: widget.fieldLabel,
        // Counter
        suffixText: '${widget.textLength.toString()}/${widget.counterLength.toString()}',
        counterText: "",
      ),

      // VALIDATION LOGIC
      validator: widget.validationLogic,

      // ACTION ON SAVE
      onSaved: (value) => setState(() => _input = value!),
      onChanged: (value) {
        setState(() {
          widget.textLength = value.length;
        });
      },
    );
  }
}



// LARGE TEXT AREA FIELD
class SimposiLargeTextField extends StatefulWidget {
  final String fieldLabel;
  final int textAreaLines;
  final validationLogic;

  const SimposiLargeTextField({
    Key? key,
    required this.fieldLabel,
    required this.textAreaLines,
    required this.validationLogic,
  }) : super(key: key);

  @override
  _SimposiLargeTextFieldState createState() => _SimposiLargeTextFieldState();
}

class _SimposiLargeTextFieldState extends State<SimposiLargeTextField> {
  String _input = ' ';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _fieldController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,

      decoration: InputDecoration(
        labelText: widget.fieldLabel,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),

      // VALIDATION LOGIC
      validator: widget.validationLogic,

      // ACTION ON SAVE
      onSaved: (value) => setState(() => _input = value!),
    );
  }
}



// TEXT PLAIN FIELD
class SimposiPlainField extends StatefulWidget {
  final TextInputType inputType;
  final String fieldLabel;
  final validationLogic;

  SimposiPlainField({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.validationLogic,
  }) : super(key: key);

  @override
  _SimposiPlainFieldState createState() => _SimposiPlainFieldState();
}

class _SimposiPlainFieldState extends State<SimposiPlainField> {
  String _input = ' ';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _fieldController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,

      decoration: InputDecoration(
        labelText: widget.fieldLabel,
      ),

      // VALIDATION LOGIC
      validator: widget.validationLogic,

      // ACTION ON SAVE
      onSaved: (value) => setState(() => _input = value!),
    );
  }
}



// SIMPOSI PHONE FIELD w/ COUNTRY CODE PICKER
class SimposiPhoneField extends StatefulWidget {

  SimposiPhoneField({
    Key? key,
  }) : super(key: key);

  @override
  _SimposiPhoneFieldState createState() => _SimposiPhoneFieldState();
}

class _SimposiPhoneFieldState extends State<SimposiPhoneField> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  void initState() {
    super.initState();
    _fieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        trailingSpace: false,
        leadingPadding: 20,
        setSelectorButtonAsPrefixIcon: true,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      initialValue: number,
      selectorTextStyle: TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Muli',
      ),
      textFieldController: _fieldController,
      formatInput: false,
      keyboardType:
      TextInputType.numberWithOptions(signed: true, decimal: true),
      inputDecoration: InputDecoration(
        labelText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          )),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}

