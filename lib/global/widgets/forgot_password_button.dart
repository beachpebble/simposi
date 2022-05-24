import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  final VoidCallback? onClick;

  const ForgotPasswordTextButton({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: SimposiAppColors.simposiDarkBlue,
          textStyle: const TextStyle(
            fontFamily: 'Muli',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          backgroundColor: Colors.white,
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
