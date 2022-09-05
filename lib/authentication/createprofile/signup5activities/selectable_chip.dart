import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

/// We need to make separate stateful to improve performance
class SelectableChip extends StatefulWidget {
  final String title;
  final Function(bool)? onClick;
  final bool selected;

  const SelectableChip(
      {Key? key, required this.title, this.onClick, this.selected = false})
      : super(key: key);

  @override
  State createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool? selected;

  bool get realSelected => selected ?? widget.selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InputChip(
        label: Text(
          widget.title,
          style: TextStyle(color: realSelected ? Colors.white : Colors.black),
        ),
        elevation: 0,
        showCheckmark: false,
        selectedColor: SimposiAppColors.simposiDarkBlue,
        selected: realSelected,
        onSelected: (bool value) {
          setState(() {
            selected = value;
            widget.onClick?.call(value);
          });
        },
      ),
    );
  }
}
