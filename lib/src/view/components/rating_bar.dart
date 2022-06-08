import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  const RatingBar(
      {Key? key,
      required this.currentRating,
      required this.maxRating,
      this.filledColor = Colors.yellow,
      this.emptyColor = Colors.grey,
      this.size = 15})
      : assert(currentRating <= maxRating);

  final int maxRating, currentRating;
  final Color filledColor, emptyColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    int _empty = maxRating - currentRating;

    return Row(children: [
      for (int i = 0; i < currentRating; i++)
        if (i != currentRating - 1 || _empty != 0)
          Padding(
              padding: const EdgeInsets.only(right: 4),
              child: _getStarIcon(filledColor))
        else
          _getStarIcon(filledColor),
      for (int i = 0; i < _empty; i++)
        if (i != _empty - 1)
          Padding(
              padding: const EdgeInsets.only(right: 4),
              child: _getStarIcon(emptyColor))
        else
          _getStarIcon(emptyColor),
    ]);
  }

  Widget _getStarIcon(Color color) => Icon(
        Icons.star,
        color: color,
        size: size,
      );
}
