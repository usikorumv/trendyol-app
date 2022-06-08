import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:trendyol_market/src/view/components/rating_bar.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/screens/product/product_screen.dart';


import '../../../../models/product/product.dart';
import '../../../constants/styles.dart';

enum ProductCardType {
  Usual,
  Favorite,
  Cart,
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, this.productCardType, required this.product})
      : super(key: key);

  final ProductCardType? productCardType;
  final ProductPresent product;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // TODO: ADD HERO TRANSITION TO PRODUCT SCREEN
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productId: product.id),
          ),
        );
      },
      child: Column(
        children: [
          if (productCardType != null)
            _getProductCardFromType(productCardType!)
          else
            RegularProductCard(product: product),
        ],
      ),
    );
  }

  Widget _getProductCardFromType(ProductCardType productCardType) {
    switch (productCardType) {
      case ProductCardType.Usual:
        return RegularProductCard(product: product);
      case ProductCardType.Favorite:
        return SizedBox();
      case ProductCardType.Cart:
        return CartProductCard(product: product);
    }
  }
}

class RegularProductCard extends StatelessWidget {
  const RegularProductCard({Key? key, required this.product}) : super(key: key);

  final ProductPresent product;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Column(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 5.75, 6, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${product.originalPrice} tmt".replaceFirst(".", ","),
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: _size.width / 29.57,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 2),
                    Text(
                      "${product.sellingPrice} tmt".replaceFirst(".", ","),
                      style: TextStyle(
                        color: kTextColor.withOpacity(0.6),
                        fontSize: _size.width / 34.5,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    LikeButton(
                      likeBuilder: (bool isLiked) {
                        return isLiked
                            ? const Icon(
                                Icons.favorite,
                                color: kRedColor,
                                size: 23,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: kRedColor,
                                size: 23,
                              );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    RatingBar(
                      currentRating: product.rating.floor(),
                      maxRating: 5,
                      filledColor: kSecondaryColor,
                      emptyColor: Colors.grey[400]!,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "(${product.feedbacksCount})",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  const CartProductCard({Key? key, required this.product}) : super(key: key);

  final ProductPresent product;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      height: 182,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 156,
                width: 126,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Доставка: 20 - 25 дней",
                      style: TextStyle(color: kTextColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Размер: 37",
                      style: TextStyle(color: kTextColor),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: kSecondaryColor,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kSecondaryColor, width: 1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 23,
                                vertical: 5,
                              ),
                              child: Text("1"),
                            ),
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.remove,
                                size: 30,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${product.sellingPrice} tmp",
                              style: kOriginalPriceTextStyle,
                            ),
                            Text(
                              "${product.originalPrice} tmp",
                              style: kSellingPriceTextStyle,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.redAccent,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
