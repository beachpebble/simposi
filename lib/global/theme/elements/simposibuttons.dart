/*
*  simposibuttons.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simposi_app_v4/global/theme/theme.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TINY TEXT BUTTON (FOOTER)
class TinyTextButton extends StatelessWidget {
  // Set Variables
  final Color color;
  final TextAlign footerButtonAlign;
  final String buttonLabel;
  final String nextPage;

  const TinyTextButton({
    Key? key,
    required this.color,
    required this.footerButtonAlign,
    required this.buttonLabel,
    required this.nextPage,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: color,
        textStyle: TextStyle(
          fontFamily: 'Muli',
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.all(0),
      ),
      child: Text(buttonLabel,
        textAlign: footerButtonAlign,
      ),
      onPressed: () => {
        Navigator.of(context).pushNamed(nextPage),
      },
    );
  }
}


// SIMPOSI TEXT BUTTON
class SimposiTextButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final String nextPage;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onClick;

  const SimposiTextButton({
    Key? key,
    required this.buttonLabel,
    required this.nextPage,
    required this.fontSize,
    required this.fontWeight, required this.onClick,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: SimposiAppColors.simposiDarkBlue,
        textStyle: TextStyle(
          fontFamily: 'Muli',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      ),
      child: Text(buttonLabel,
        textAlign: TextAlign.center,
      ),
      onPressed: onClick
    );
  }
}


// Login Button with Forward Chevron for Get Started Page
class LoginForwardTextButton extends StatelessWidget {
  final VoidCallback? onClick;

  const LoginForwardTextButton({Key? key, this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          textStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          backgroundColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Log In",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
        onPressed: onClick
      ),
    );
  }
}


// GET STARTED BUTTON
class GetStartedButton extends StatelessWidget {

  final VoidCallback? onClick;

  const GetStartedButton({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.white,
        onPrimary: SimposiAppColors.simposiDarkGrey,
        textStyle: TextStyle(
          fontFamily: 'Muli',
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
      ),
      child: Text(
        "Get Started",
        textAlign: TextAlign.center,
      ),
      onPressed: onClick
    );
  }
}


// ADD PHOTO BUTTON (SIGNUP)
class AddPhotoButton extends StatelessWidget {
  // Set Variables
  final onPressed;

  const AddPhotoButton({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Image.asset('assets/images/addphoto.png'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}

// TODO: Enable button to upload images from the device
// ADD PHOTO BUTTON (CREATE EVENT)
class AddEventImageButton extends StatelessWidget {
  // Set Variables
  final onPressed;

  const AddEventImageButton({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: 76,
      child: ElevatedButton(
        onPressed: null,
        child: Stack(
          children: [
            Center(child: Image.asset('assets/images/imagepickerbackground.png')),
            Center(child: Icon(Icons.camera_alt_rounded,
            color: SimposiAppColors.simposiLightGrey,)),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}


// CONTINUE BUTTON
class ContinueButton extends StatefulWidget {
  final String nextPage;

  const ContinueButton({Key? key, required this.nextPage})
      : super(key: key);

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiLightGrey;
                return SimposiAppColors.simposiDarkBlue;
              }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiDarkGrey;
                return Colors.white;
              }),
        ),

        // Label
        child: Text('Continue'),

        // Button Actions
        onPressed: () => {
          Navigator.of(context).pushNamed(widget.nextPage),
        },
      ),
    );
  }
}


// BIG GREY/BLUE SELECT BUTTON
class BigGBSelectButton extends StatefulWidget {
  // Set Variables
  final String buttonLabel;
  final buttonAction;
  final bool isSelected = false;

  const BigGBSelectButton({
    required this.buttonLabel,
    required this.buttonAction,
    Key? key,
  }) : super(key: key);

  @override
  _BigGBSelectButtonState createState() => _BigGBSelectButtonState();
}

class _BigGBSelectButtonState extends State<BigGBSelectButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(20),
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return 0;
              }
              return 0;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiLightGrey;
                return SimposiAppColors.simposiDarkBlue;
              }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiDarkGrey;
                return Colors.white;
              }),
        ),

        // Label
        child: Text(widget.buttonLabel),

        onPressed: widget.buttonAction,
      ),
    );
  }
}



// BIG BUTTON
class BigButton extends StatefulWidget {
  // Set Variables
  final String buttonLabel;
  final buttonAction;
  final Color buttonColor;
  final Color textColor;

  const BigButton({
    required this.buttonLabel,
    required this.buttonAction,
    required this.buttonColor,
    required this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  _BigButtonState createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return widget.buttonColor;
                return SimposiAppColors.simposiDarkBlue;
              }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return widget.textColor;
                return Colors.white;
              }),
        ),

        // Label
        child: Text(widget.buttonLabel),

        onPressed: widget.buttonAction,
      ),
    );
  }
}


// SUBSCRIBE BUTTON ON PROFILE PAGE
class SubscribeButton extends StatelessWidget {
  // Set Variables
  final String nextPage;

  const SubscribeButton({
    Key? key,
    required this.nextPage,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        shape: StadiumBorder(),
        elevation: 0,
        primary: SimposiAppColors.simposiDarkBlue,
      ),
      child: Text(
        "Subscribe",
      ),

      // ACTION
      onPressed: () => {
        Navigator.of(context).pushNamed(nextPage),
      },

    );
  }
}


// MEET NOW PINK BUTTON
class SmallPinkButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final String nextPage;

  const SmallPinkButton({
    Key? key,
    required this.buttonLabel,
    required this.nextPage,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: SimposiAppColors.simposiPink,
        textStyle: TextStyle(
          fontFamily: 'Muli',
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        elevation: 0,
      ),
      // TODO: Enable Meet Now Button
      onPressed: () => {
        Navigator.of(context).pushNamed(nextPage),
      },
      child: Text(
        buttonLabel,
        textAlign: TextAlign.center,
      ),
    );
  }
}



// COVID AGREE BUTTON
class AgreeButton extends StatefulWidget {

  @override
  _AgreeButtonState createState() => _AgreeButtonState();
}

class _AgreeButtonState extends State<AgreeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
        ),
        elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return 0;
            }
            return 0; // Defer to the widget's default.
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled))
                return SimposiAppColors.simposiLightGrey;
              return SimposiAppColors.simposiDarkBlue;
            }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled))
                return SimposiAppColors.simposiDarkGrey;
              return Colors.white;
            }),
      ),

      // Label
      child: Text('I Agree'),

      onPressed: () {},
    );
  }
}


// PRESS & HOLD CHECK IN BUTTON
class BigCheckInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiLightGrey;
                return SimposiAppColors.simposiFadedBlue;
              }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return SimposiAppColors.simposiDarkGrey;
                return SimposiAppColors.simposiDarkBlue;
              }),
        ),

        // Label
        child: Text('Press & Hold to Set Location'),

        onPressed: () {},
        onLongPress: () => {
          Navigator.of(context).pushNamed('/groupfinder'),
        },
      ),
    );
  }
}



// SIMPOSI BIG BUTTON
class SimposiBigButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final Color buttonColor;
  final Color textColor;
  final String nextPage;

  const SimposiBigButton({
    Key? key,
    required this.buttonLabel,
    required this.buttonColor,
    required this.textColor,
    required this.nextPage,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: buttonColor,
          onPrimary: textColor,
          textStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
        ),
        child: Text(
          buttonLabel,
          textAlign: TextAlign.center,
        ),
        onPressed: () => {
          Navigator.of(context).pushNamed(nextPage),
        },
      ),
    );
  }
}














