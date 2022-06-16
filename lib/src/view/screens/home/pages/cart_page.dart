import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: _size.height,
      child: Stack(
        children: [
          // SingleChildScrollView(
          //   child: Column(
          //     children: [
          // SizedBox(height: 50),

          //       for (int i = 0; i < Product.testProducts.length; i++)
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 6),
          //           child: ProductCard(
          //             product: Product.testProducts[i],
          //             productCardType: ProductCardType.Cart,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
          const Center(
            child: Text("Cart is empty",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Итого",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "0 tmp",
                        style: kSellingPriceTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: kLightGreyColor[0],
                        // primary: kSecondaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Оформить заказ",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
