/*
*  formfields.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:flutter/material.dart';
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
                icon: const Icon(Icons.close,
                    size: 20, color: SimposiAppColors.simposiLightGrey),
                onPressed: () => fieldController.clear(),
              ),
      ),
      validator: validationLogic,
    );
  }
}

// TEXT FIELD WITH COUNTER
class SimposiCounterField extends StatefulWidget {
  final TextInputType inputType;
  final String fieldLabel;
  final int counterLength;

  final validationLogic;
  final Function(String?)? onSave;
  final TextEditingController fieldController;

  const SimposiCounterField({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.counterLength,
    required this.validationLogic,
    this.onSave,
    required this.fieldController,
  }) : super(key: key);

  @override
  _SimposiCounterFieldState createState() => _SimposiCounterFieldState();
}

class _SimposiCounterFieldState extends State<SimposiCounterField> {
  int textLength = 0;

  @override
  void initState() {
    super.initState();
    widget.fieldController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.fieldController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,
      maxLength: widget.counterLength,

      style: const TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        labelText: widget.fieldLabel,
        // Counter
        suffixText:
            '${textLength.toString()}/${widget.counterLength.toString()}',
        counterText: "",
      ),

      // VALIDATION LOGIC
      validator: widget.validationLogic,

      // ACTION ON SAVE
      onSaved: (value) {
        widget.onSave?.call(value);
      },
      onChanged: (value) {
        setState(() {
          textLength = value.length;
        });
      },
    );
  }
}

// LARGE TEXT AREA FIELD
class SimposiLargeTextField extends StatelessWidget {
  final String fieldLabel;
  final int textAreaLines;
  final validationLogic;
  final Function(String?)? onSave;
  final TextEditingController? fieldController;

  const SimposiLargeTextField({
    Key? key,
    required this.fieldLabel,
    required this.textAreaLines,
    required this.validationLogic,
    this.onSave,
    this.fieldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: false,
      showCursor: true,
      maxLines: 5,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: fieldLabel,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      validator: validationLogic,
      onSaved: (value) => onSave?.call(value),
    );
  }
}

// TEXT PLAIN FIELD
class SimposiPlainField extends StatefulWidget {
  final TextInputType inputType;
  final String fieldLabel;
  final validationLogic;
  final TextEditingController? fieldController;
  final Function(String?)? onSave;

  const SimposiPlainField({
    Key? key,
    required this.inputType,
    required this.fieldLabel,
    required this.validationLogic,
    this.fieldController,
    this.onSave,
  }) : super(key: key);

  @override
  _SimposiPlainFieldState createState() => _SimposiPlainFieldState();
}

class _SimposiPlainFieldState extends State<SimposiPlainField> {
  late final TextEditingController _fieldController;

  @override
  void initState() {
    super.initState();
    _fieldController = widget.fieldController ?? TextEditingController();
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
      onSaved: (value) => widget.onSave?.call(value),
    );
  }
}
