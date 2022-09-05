import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(),
    );
  }

}