import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class RsvpIndicator extends StatelessWidget {

  final int acceptedCount;

  const RsvpIndicator({Key? key, required this.acceptedCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 Stack(
      alignment: Alignment.center,
      children: [
        Tooltip(
          message: 'People who said yes!',
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: TextStyle(
            color: SimposiAppColors.simposiPink,
          ),
          child: Column(
            children: [
              // TODO: Enable IF ELSE statement on these dots for how many people have RSVPd (Pink or LightGrey)
              // TODO: Color from bottom to top as RSVPs come in
              Icon(Icons.circle,
                color: acceptedCount > 0 ? SimposiAppColors.simposiPink : SimposiAppColors.simposiLightGrey,
                size: 10,
              ),
              SizedBox(height: 5),
              Icon(Icons.circle,
                color: acceptedCount > 1 ? SimposiAppColors.simposiPink : SimposiAppColors.simposiLightGrey,
                size: 10,
              ),
              SizedBox(height: 5),
              Icon(Icons.circle,
                color: acceptedCount > 2 ? SimposiAppColors.simposiPink : SimposiAppColors.simposiLightGrey,
                size: 10,
              ),
              SizedBox(height: 5),
              Icon(Icons.circle,
                color: acceptedCount > 3 ? SimposiAppColors.simposiPink : SimposiAppColors.simposiLightGrey,
                size: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

}