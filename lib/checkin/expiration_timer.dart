import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpirationTimer extends StatefulWidget {
  const ExpirationTimer({Key? key, required this.eventDate}) : super(key: key);

  final DateTime eventDate;

  @override
  _ExpirationTimerState createState() => _ExpirationTimerState();
}

class _ExpirationTimerState extends State<ExpirationTimer> {
  late Timer _timer;
  String time = "";

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        DateTime now = DateTime.now().toUtc();
        Duration dif = widget.eventDate.add(Duration(hours: 1)).toUtc().difference(now);
        int inMin = dif.inMinutes;
        int hours = inMin ~/ 60;
        int minutes = inMin - 60 * hours;
        if (hours < 0 || minutes < 0) {
          time = "--:--";
        } else {
          time = "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")} m";
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
