import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

final TextStyle kOriginalPriceTextStyle = TextStyle(
  color: kTextColor.withOpacity(0.6),
  fontSize: 16,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.lineThrough,
);

const TextStyle kSellingPriceTextStyle = TextStyle(
  color: kSecondaryColor,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
