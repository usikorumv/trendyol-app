import 'package:flutter/material.dart';

import '../../../components/rating_bar.dart';
import '../../../constants/colors.dart';

class FavouriteListTileWidget extends StatelessWidget {
  const FavouriteListTileWidget({
    Key? key,
  }) : super(key: key);

  //final ProductPresent? product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(
        width: 100,
        height: 130,
        child: Image(
          image: NetworkImage(
            'https://i.stack.imgur.com/zXU6v.png',
          ),
          fit: BoxFit.contain,
          width: 100,
          height: 130,
        ),
      ),
      title: const Text('Collection T-shirt - Black - Regular'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          RatingBar(
            currentRating: 0, //product!.rating.floor() ?? 0,
            maxRating: 5,
            filledColor: kSecondaryColor,
            emptyColor: Colors.grey[400]!,
          ),
          const SizedBox(width: 5),
          const SizedBox(
            height: 12,
          ),
          const Text(
            '28,00 \$',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 125,
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green),
                    )),
                    elevation: MaterialStateProperty.all(0)),
                child: Row(
                  children: const [
                    Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(Icons.shopping_cart_outlined, color: Colors.black)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
