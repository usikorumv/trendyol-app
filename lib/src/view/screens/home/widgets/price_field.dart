import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class PriceField extends StatelessWidget {
  const PriceField({Key? key, required this.defaultPrice}) : super(key: key);

  final double defaultPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 125,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: kLightGreyColor[1],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: defaultPrice.toString().replaceAll(".", ","),
          hintStyle: TextStyle(color: kDarkGreyColor[0]),
        ),
      ),
    );
  }
}
