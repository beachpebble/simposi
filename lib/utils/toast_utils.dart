import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

void showErrorToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white38,
      textColor: SimposiAppColors.simposiPink,
      fontSize: 16.0,
      gravity: ToastGravity.TOP,

  );
}

void showInfoToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white38,
      textColor: SimposiAppColors.simposiDarkBlue,
      fontSize: 16.0,
      webPosition: "top"
  );
}