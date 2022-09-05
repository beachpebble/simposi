import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/checkin/bloc/group_finder_bloc.dart';
import 'package:simposi_app_v4/checkin/group_user_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class GroupLocator extends StatelessWidget {
  const GroupLocator({Key? key, required this.users, this.userSelected, required this.startAngle}) : super(key: key);

  final List<GroupUserWithRange> users;
  final GroupUserWithRange? userSelected;

  final int margin = 70;
  final int textHeight = 16;
  final double startAngle;


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final radiusFull = (width - margin) / 2;
    var angleI = startAngle;

    return SizedBox(
      width: width,
      height: width,
      child: CustomPaint(
        painter: CirclesPainter(margin),
        child: Stack(
            alignment: Alignment.center,
          children: [
            Positioned(
                bottom: margin/2-textHeight,
                child: _circleText(AppLocalizations.of(context)!.groupFinder1030m)),
            Positioned(
                bottom: margin/2 +radiusFull/3 -textHeight,
                child: _circleText(AppLocalizations.of(context)!.groupFinder210m)),
            Positioned(
                bottom: margin/2 +radiusFull*2/3-textHeight,
                child: _circleText(AppLocalizations.of(context)!.groupFinder12m)),
            Positioned(
                child:
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: SimposiAppColors.simposiLightBlue),

                  ),
                  child: Center(child: Text(AppLocalizations.of(context)!.groupFinderMe, style: const TextStyle().copyWith(fontSize: 11, fontWeight: FontWeight.w600),)),
                )
                 ),

            Stack(
              alignment: Alignment.center,
              children: users.map((user) {
                final radius  = _getRadius(user.rangeClass, radiusFull);
                final radius2  = _getRadius2(user.rangeClass, radiusFull, margin.toDouble());
                final angle = angleI + 2;
                angleI = angle;
                return Positioned(
left: radius2 + radius - radius*sin(angle) + margin/2 - 25,
                  top: radius2 + radius + radius*cos(angle)+ margin/2-35,
                  child: GroupUserBubble(user: user, onTap: (){
                    context.read<GroupFinderBloc>().add(GroupFinderUserSelect(user));
                  }));}).toList(),
            )
          ],
        ),
      ),
    );
  }

  // Widget _centeredUser(GroupUserWithRange user) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //     Text(userSelected!.user.name, style: TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
  //     Text("~${userSelected!.range}m", style: TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: SimposiAppColors.simposiPink),),
  //   ],);
  // }

  double _getRadius(Range range, double radius) {
    switch (range) {
      case Range.R10_30: return radius;
      case Range.R2_10: return radius*2/3;
      default: return radius/3;
    }
  }

  double _getRadius2(Range range, double radius, double margin) {
    switch (range) {
      case Range.R10_30: return 0;
      case Range.R2_10: return radius/3 ;
      default: return radius*2/3;
    }
  }

  Widget _circleText(String text) {
    return Text(text, style: const TextStyle().copyWith(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w600),);
  }
}

class CirclesPainter extends CustomPainter {
  final int margin ;

  CirclesPainter(this.margin);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;
    final paint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.2)
      ..strokeWidth = 5;

    canvas.drawCircle(Offset(center.width, center.height),
        ((size.width - margin) / 2), paint);
    final textPainter = TextPainter(
        text: TextSpan(text: '10-30m', style: const TextStyle().copyWith(color: Colors.black, fontSize: 12)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    )..layout(maxWidth: 50);

    paint.color = Colors.lightBlue.withOpacity(0.3);
    canvas.drawCircle(Offset(center.width, center.height),
        ((size.width - margin) / 2) * 2 / 3, paint);
    paint.color = Colors.white;
    canvas.drawCircle(Offset(center.width, center.height),
        ((size.width - margin) / 2) / 3, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
