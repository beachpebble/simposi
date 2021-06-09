import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Validators { PASSWORD, PHONE }

FormFieldValidator<String>? getValidator(
    BuildContext context, Validators validatorType) {
  switch (validatorType) {
    case Validators.PASSWORD:
      return (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.validatePasswordNotEmpty;
        } else if (value.length < 8) {
          return AppLocalizations.of(context)!.validatePasswordLength;
        } else {
          return null;
        }
      };
    case Validators.PHONE:
      return (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.validatePhoneNotEmpty;
        } else if (value.length < 8) {
          return AppLocalizations.of(context)!.validatePhoneLength;
        } else {
          return null;
        }
      };
  }
}
