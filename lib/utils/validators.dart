import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Validators { PASSWORD, PHONE, NAME, EMAIL, URL_LINK }

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
        } else if (value.length > 14) {
          return AppLocalizations.of(context)!.validatePhoneLengthMax;
        } else {
          return null;
        }
      };
    case Validators.NAME:
      return (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.validatePhoneNotEmpty;
        } else if (value.length < 4) {
          return AppLocalizations.of(context)!.validatePhoneLength;
        } else {
          return null;
        }
      };
    case Validators.EMAIL:
      return (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.validateEmailNotEmpty;
        } else if (!EmailValidator.validate(value)) {
          return AppLocalizations.of(context)!.validateEmailNotValid;
        } else {
          return null;
        }
      }; 
      case Validators.URL_LINK:
      return (value) {
        if (value == null || value.isEmpty) {
          return null;
        } else if (!value.startsWith("https://")) {
          return AppLocalizations.of(context)!.validateUrlNotValid;
        } else {
          return null;
        }
      };
  }
}
