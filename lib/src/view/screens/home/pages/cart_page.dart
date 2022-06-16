import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import 'home/widgets/custom_serch_field.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[Container()],
          flexibleSpace: Container(
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(
                color: kLightGreyColor[0],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CustomSearchField()
          )
      ),
      body: SizedBox(
        height: _size.height,
        child: Stack(
          children: [
            ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
                  return Container();
                  //return  CartListTileWidget(product: product);
                }
            ),
            // const Center(
            //   child: Text("Cart is empty",
            //       style: TextStyle(
            //         color: kTextColor,
            //         fontSize: 24,
            //         fontWeight: FontWeight.w500,
            //       )),
            // ),
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
      ),
    );
  }
}
