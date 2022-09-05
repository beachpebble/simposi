import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class PasswordField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const PasswordField({Key? key, this.label, this.controller, this.validator})
      : super(key: key);

  @override
  State createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: _passwordVisible,
      showCursor: true,

      style: const TextStyle(
        color: SimposiAppColors.simposiLightText,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),

      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding: const EdgeInsets.all(20),
        labelStyle: const TextStyle(
          color: SimposiAppColors.simposiLightText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
        ),

        suffixIcon: widget.controller?.text.isEmpty == true
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

        // INITIAL STATE
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiLightGrey,
          ),
        ),

        // FOCUS STATE
        focusColor: SimposiAppColors.simposiDarkBlue,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(
            color: SimposiAppColors.simposiDarkBlue,
          ),
        ),

        // FOCUS ERROR STATE
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),

        // ERROR STATE
        errorStyle: const TextStyle(
          color: SimposiAppColors.simposiPink,
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),
      ),

      // VALIDATION LOGIC
      validator: widget.validator,
    );
  }
}
