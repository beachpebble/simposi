import 'package:flutter/material.dart';

class ResendCountDown extends AnimatedWidget {

  const ResendCountDown({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  Padding build(BuildContext context) {
    final clockTimer = Duration(seconds: animation.value);

    final timerText =
        'Resend in ${clockTimer.inSeconds.remainder(60).toString()} seconds';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        timerText,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}