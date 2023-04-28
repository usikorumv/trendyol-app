import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/products/product_present.dart';
import 'package:trendyol_market/src/view/components/product_card.dart';

import '../../../constants/colors.dart';

class TitleAndProducts extends StatelessWidget {
  const TitleAndProducts({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  final String title;
  final List<ProductPresent> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Text(
            title,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 13),
          child: Row(
            children: [
              for (int i = 0; i < products.length; i++)
                Container(
                  width: 171,
                  padding: const EdgeInsets.only(right: 7),
                  child: ProductCard(
                    product: products[i],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
