import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularProgressIndicator(),
      width: 48,
      height: 48,
    );
  }

}