import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/model/interest.dart';

class TagsCloud extends StatelessWidget {

  final List<Interest> interests;

  const TagsCloud({Key? key, required this.interests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      runSpacing: -8.0,
      children: interests
          .map((item) => Padding(
        padding: const EdgeInsets.all(2.0),
            child: InputChip(
        label: Text(
            item.title,
            style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        showCheckmark: false,
        selectedColor: SimposiAppColors.simposiDarkBlue,
      ),
          ))
          .toList(),
    );
  }

}