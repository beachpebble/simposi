/*
*  simposibuttons.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// TINY TEXT BUTTON (FOOTER)
class TinyTextButton extends StatelessWidget {
  // Set Variables
  final Color color;
  final TextAlign footerButtonAlign;
  final String buttonLabel;
  final VoidCallback nextPage;

  const TinyTextButton({
    Key? key,
    required this.color,
    required this.footerButtonAlign,
    required this.buttonLabel,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: color,
        textStyle: const TextStyle(
          fontFamily: 'Muli',
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(0),
      ),
      child: Text(
        buttonLabel,
        textAlign: footerButtonAlign,
      ),
      onPressed: () => nextPage,
    );
  }
}

// SIMPOSI TEXT BUTTON
class SimposiTextButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onClick;

  const SimposiTextButton({
    Key? key,
    required this.buttonLabel,
    required this.fontSize,
    required this.fontWeight,
    required this.onClick,
  }) : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        ),
        onPressed: onClick,
        child: Text(
          buttonLabel,
          textAlign: TextAlign.center,
        ));
  }
}

// Login Button with Forward Chevron for Get Started Page
class LoginForwardTextButton extends StatelessWidget {
  final VoidCallback? onClick;

  const LoginForwardTextButton({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'Muli',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Log In",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Icon(Icons.chevron_right),
          ],
        ));
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
          textStyle: const TextStyle(
            fontFamily: 'Muli',
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
        ),
        onPressed: onClick,
        child: const Text(
          "Get Started",
          textAlign: TextAlign.center,
        ));
  }
}

// CONTINUE BUTTON
class ContinueButton extends StatelessWidget {
  final VoidCallback? buttonAction;
  final String buttonLabel;

  const ContinueButton(
      {Key? key, this.buttonAction, this.buttonLabel = 'Continue'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return SimposiAppColors.simposiLightGrey;
            }
            return SimposiAppColors.simposiDarkBlue;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return SimposiAppColors.simposiDarkGrey;
            }
            return Colors.white;
          }),
        ),
        // Button Actions
        onPressed: buttonAction,

        // Label
        child: Text(buttonLabel),
      ),
    );
  }
}

// BIG GREY/BLUE SELECT BUTTON
class BigGBSelectButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final VoidCallback? buttonAction;
  final bool isSelected;

  const BigGBSelectButton({
    required this.buttonLabel,
    required this.buttonAction,
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
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
            return isSelected
                ? SimposiAppColors.simposiDarkBlue
                : SimposiAppColors.simposiLightGrey;

            //   if (states.contains(MaterialState.disabled))
            //     return SimposiAppColors.simposiLightGrey;
            // return SimposiAppColors.simposiDarkBlue;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return isSelected ? Colors.white : SimposiAppColors.simposiDarkGrey;
            // if (states.contains(MaterialState.disabled))
            //   return SimposiAppColors.simposiDarkGrey;
            // return Colors.white;
          }),
        ),

        onPressed: buttonAction,

        // Label
        child: Text(buttonLabel),
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
  State createState() => _BigButtonState();
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
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.buttonColor;
            }
            return SimposiAppColors.simposiDarkBlue;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.textColor;
            }
            return Colors.white;
          }),
        ),

        onPressed: widget.buttonAction,

        // Label
        child: Text(widget.buttonLabel),
      ),
    );
  }
}

// SUBSCRIBE BUTTON ON PROFILE PAGE
class SubscribeButton extends StatelessWidget {
  // Set Variables
  final VoidCallback onClick;

  const SubscribeButton({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
        shape: const StadiumBorder(),
        elevation: 0,
        primary: SimposiAppColors.simposiDarkBlue,
      ),

      // ACTION
      onPressed: onClick,
      child: const Text(
        "Subscribe",
      ),
    );
  }
}

// SMALL PINK BUTTON
class SmallPinkButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final nextPage;

  const SmallPinkButton({
    Key? key,
    required this.buttonLabel,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: SimposiAppColors.simposiPink,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: SimposiAppColors.simposiPink, width: 1.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 0,
      ),
      // TODO: Enable Meet Now Button
      onPressed: nextPage,
      child: Text(
        buttonLabel,
        textAlign: TextAlign.center,
      ),
    );
  }
}

// SMALL BLUE BUTTON
class SmallBlueButton extends StatelessWidget {
  // Set Variables
  final String buttonLabel;
  final nextPage;

  const SmallBlueButton({
    Key? key,
    required this.buttonLabel,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: SimposiAppColors.simposiDarkBlue,
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: SimposiAppColors.simposiDarkBlue, width: 0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        elevation: 0,
      ),
      // TODO: Enable Meet Now Button
      onPressed: nextPage,
      child: Text(
        buttonLabel,
        textAlign: TextAlign.center,
      ),
    );
  }
}

// COVID AGREE BUTTON
class AgreeButton extends StatelessWidget {
  final bool agree;
  final VoidCallback? onClick;

  const AgreeButton({Key? key, this.agree = false, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
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
          return agree
              ? SimposiAppColors.simposiDarkBlue
              : SimposiAppColors.simposiLightGrey;
          // if (states.contains(MaterialState.disabled))
          //   return SimposiAppColors.simposiLightGrey;
          // return SimposiAppColors.simposiDarkBlue;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return agree ? Colors.white : SimposiAppColors.simposiDarkBlue;
          // if (states.contains(MaterialState.disabled))
          //   return SimposiAppColors.simposiDarkGrey;
          // return Colors.white;
        }),
      ),

      onPressed: onClick,

      // Label
      child: const Text('I Agree'),
    );
  }
}

// PRESS & HOLD CHECK IN BUTTON
class BigCheckInButton extends StatefulWidget {
  final VoidCallback onClick;

  const BigCheckInButton({Key? key, required this.onClick}) : super(key: key);

  @override
  State<BigCheckInButton> createState() => _BigCheckInButtonState();
}

class _BigCheckInButtonState extends State<BigCheckInButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
        if (_controller.value == 1) {
          _controller.reset();
          widget.onClick.call();
        }
      });
    //_tween = Tween<double>(begin: 0.0, end: 1.00);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          if (_controller.status == AnimationStatus.forward) {
            _controller.reverse();
          }
        },
        child: SizedBox(
          height: 55,
          child: Stack(
            children: [
              SizedBox(
                height: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: LinearProgressIndicator(
                    color: SimposiAppColors.simposiDarkBlue,
                    backgroundColor: SimposiAppColors.simposiFadedBlue,
                    value: _animation.value,
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text('Press & Hold to Set Location')),
            ],
          ),
        ),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: buttonColor,
          onPrimary: textColor,
          textStyle: const TextStyle(
            fontFamily: 'Muli',
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
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
