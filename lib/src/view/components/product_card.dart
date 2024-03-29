// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:trendyol_market/src/models/products/product_present.dart';
import 'package:trendyol_market/src/view/components/rating_bar.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/screens/product/product_screen.dart';

import '../constants/styles.dart';

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
    return GestureDetector(
      onTap: () {
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
        return const SizedBox();
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
          SizedBox(
            height: 255,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (context, Object exception, StackTrace? stackTrace) {
                return Image.asset("assets/images/image-error.png");
              },
            ),
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
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: product.campaign + " ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: product.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
    return Container(
      height: 182,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
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
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Доставка: 20 - 25 дней",
                      style: TextStyle(color: kTextColor),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Размер: 37",
                      style: TextStyle(color: kTextColor),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 23,
                                vertical: 5,
                              ),
                              child: const Text("1"),
                            ),
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.remove,
                                size: 30,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
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
              icon: const Icon(
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
