import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpirationTimer extends StatefulWidget {
  const ExpirationTimer({Key? key, required this.eventDate}) : super(key: key);

  final DateTime eventDate;

  @override
  State createState() => _ExpirationTimerState();
}

class _ExpirationTimerState extends State<ExpirationTimer> {
  late Timer _timer;
  String time = "";

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        final now = DateTime.now().toUtc();
        final dif = widget.eventDate
            .add(const Duration(hours: 1))
            .toUtc()
            .difference(now);
        final inMin = dif.inMinutes;
        final hours = inMin ~/ 60;
        final minutes = inMin - 60 * hours;
        if (hours < 0 || minutes < 0) {
          time = "--:--";
        } else {
          time =
              "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")} m";
        }

        if (hours == 0 && minutes == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.groupFinderSessionExpired(time));
  }
}
