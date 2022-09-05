import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class SimposiCounterBubble extends StatelessWidget {
  final String count;

  const SimposiCounterBubble({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: SimposiAppColors.simposiPink,
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: const BoxConstraints(
        minWidth: 20,
        minHeight: 20,
      ),
      child: Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}