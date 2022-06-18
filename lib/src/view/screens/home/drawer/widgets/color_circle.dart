import 'package:flutter/material.dart';

class ColorCircle extends StatefulWidget {
  const ColorCircle({Key? key}) : super(key: key);

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
            isSelected = !isSelected;
          });
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: isSelected ? Colors.black : Colors.transparent,
          child: const CircleAvatar(
            radius: 24,
          ),
        ),
      ),
    );
  }
}
