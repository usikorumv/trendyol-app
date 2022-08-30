import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/models/colors/color.dart';

class ColorCircle extends StatefulWidget {
  const ColorCircle(
      {Key? key, required this.onTap, required this.color, required this.id})
      : super(key: key);

  final int id;
  final Color color;
  final Function(int) onTap;

  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.onTap(widget.id);

            isSelected = !isSelected;
          });
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: isSelected ? kSecondaryColor : Colors.transparent,
          child: const CircleAvatar(
            radius: 24,
          ),
        ),
      ),
    );
  }
}
