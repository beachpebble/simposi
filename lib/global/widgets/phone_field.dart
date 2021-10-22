import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/utils/validators.dart';

class PhoneField extends StatefulWidget {
  PhoneField({Key? key, required this.controller, required this.onSave, this.showClearIcon = true, this.initialPhone}) : super(key: key);
  final TextEditingController? controller;
  final Function(String newValue) onSave;
  final bool showClearIcon;
  final String? initialPhone;

  @override
  _PhoneFieldState createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {

  late String prefix;

  @override
  void initState() {
    super.initState();
    String? pref = getPrefixByPhone(widget.initialPhone);
    if (pref != null && pref.isNotEmpty && widget.initialPhone != null) {
      widget.controller?.text = widget.initialPhone!.substring(pref.length);
      prefix = pref;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
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
        prefixIcon:  CountryCodePicker(
          onChanged: (val) {
            prefix = val.dialCode ??"";
          },
          onInit: (val) {
            prefix = val?.dialCode ??"";
          },
          initialSelection: getPrefixByPhone(widget.initialPhone) ?? '+380',
          favorite: ['+380'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        labelText: ' Phone Number',
        //contentPadding: EdgeInsets.all(20),
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
            )),

        // ERROR STATE
        errorStyle: TextStyle(
          color: SimposiAppColors.simposiPink,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide(
              color: SimposiAppColors.simposiPink,
            )),

        suffixIcon: widget.showClearIcon ? widget.controller?.text.isEmpty == true
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close,
              size: 20, color: SimposiAppColors.simposiLightGrey),
          onPressed: () => widget.controller?.clear(),
        ) : null,
      ),
      validator: getValidator(context, Validators.PHONE),
      // OUTPUT ACTIONS
      onSaved: (value) {
        widget.onSave(prefix + value!);
      },
    );
  }

  String? getPrefixByPhone(String? phone) {
    if (phone == null)
      return null;
    for (Map item in codes) {
      if (phone.startsWith(item['dial_code']))
        return item['dial_code'];
    }
    return null;
  }
}
