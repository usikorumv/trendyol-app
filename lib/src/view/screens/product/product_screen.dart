import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import 'package:trendyol_market/src/logic/blocs/cart/cart_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/product/product_bloc.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';

import 'package:trendyol_market/src/view/components/rating_bar.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/constants/styles.dart';
import 'package:trendyol_market/src/view/screens/product/option_state.dart';

import 'package:trendyol_market/src/view/screens/product/widgets/feedback_card.dart';
import 'package:trendyol_market/src/view/screens/product/widgets/title_and_products.dart';
import 'package:trendyol_market/src/view/screens/product/widgets/title_and_widget.dart';

import 'widgets/product_image_options.dart';
import 'widgets/product_size_option.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int? _currentColorID, _currentSizeID;

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(LoadProduct(id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Scaffold(
            backgroundColor: kPrimaryColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ProductLoaded) {
          Product product = state.product;

          _currentColorID = 0;
          _currentSizeID ??= (product.sizes.map((size) => size.slug).toList())
              .indexOf(product.startProductSize);

          return content(product);
        }

        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 70,
                  color: kLightGreyColor[3],
                ),
              ),
              Text(
                "Something went Wrong!",
                style: TextStyle(
                  color: kLightGreyColor[3],
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget content(Product product) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: kPrimaryColor,
        padding: const EdgeInsets.only(left: 12, right: 4),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(width: 10),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                bool inCart =
                    context.read<CartBloc>().cartProducts.contains(product);

                return Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: !inCart ? kSecondaryColor : kLightGreyColor[0],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: () {
                        if (state is CartAdding) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.25,
                            ),
                          );
                        }

                        if (state is CartAdded) {
                          context.read<CartBloc>().add(LoadCart());
                        }

                        return Text(
                          !inCart ? "Добавить в корзину" : "В корзине",
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }(),
                    ),
                    onPressed: () {
                      if (!inCart && state is! CartAdding) {
                        context
                            .read<CartBloc>()
                            .add(AddToCart(product: product, size: "x"));

                        setState(() {});
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height - 200,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Stack(
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 32,
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                actions: [
                  LikeButton(
                    likeBuilder: (bool isLiked) {
                      return isLiked
                          ? const Icon(
                              Icons.favorite,
                              color: kRedColor,
                              size: 30,
                            )
                          : Stack(
                              children: const [
                                Icon(
                                  Icons.favorite_outline_rounded,
                                  size: 32,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.favorite_outline_rounded,
                                  size: 30,
                                ),
                              ],
                            );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Stack(
                      children: const [
                        Icon(
                          Icons.share_rounded,
                          size: 32,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.share_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    product.imageUrls[0], // ABOBA
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            // controller: controller,
            child: Container(
              color: kPrimaryColor,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 11),
                        Row(
                          children: [
                            RatingBar(
                              currentRating: product.rating.ceil(),
                              maxRating: 5,
                              filledColor: kSecondaryColor,
                            ),
                            const SizedBox(width: 7.19),
                            Text(
                              "|  Коментарии (${product.feedbacksCount})",
                              style: const TextStyle(
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // TODO: make colors
                  // if (product.colors!.isNotEmpty)
                  //   Column(
                  //     children: [
                  //       SizedBox(height: 10),
                  //       TitleAndWidget(
                  //         title: "Цвет",
                  //         child: SingleChildScrollView(
                  //           padding: EdgeInsets.only(left: 20),
                  //           scrollDirection: Axis.horizontal,
                  //           child: Row(
                  //             children: [
                  //               for (int i = 0;
                  //                   i < product.colors!.length;
                  //                   i++)
                  //                 Padding(
                  //                   padding: EdgeInsets.only(right: 10),
                  //                   child: ProductImageOption(
                  //                     id: i,
                  //                     imgUrl: product.imageUrls[0], //BABABA
                  //                     onTap: (index) =>
                  //                         _currentProductColorID,
                  //                     isSelected: _currentProductColorID == i,
                  //                   ),
                  //                 ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      TitleAndWidget(
                        title: "Размер",
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < product.sizes.length; i++)
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (product.sizes[i].inStock) {
                                          setState(() {
                                            _currentSizeID = i;
                                          });
                                        }
                                      },
                                      child: ProductSizeOption(
                                        optionState: product.sizes[i].inStock
                                            ? i == _currentSizeID
                                                ? OptionState.Selected
                                                : OptionState.Deselected
                                            : OptionState.Disabled,
                                        size: product.sizes[i].name,
                                      ),
                                    )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  const Divider(
                    color: Color(0xFFADABAB),
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 21, 20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Описание",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 23),
                        for (int i = 0;
                            i < product.description.split("\n").length;
                            i++)
                          if (i != product.description.split("\n").length - 1)
                            Column(
                              children: [
                                Text(
                                  "• " + product.description.split("\n")[i],
                                  style: const TextStyle()
                                      .copyWith(color: kTextColor),
                                ),
                                const SizedBox(height: 21),
                              ],
                            )
                          else
                            Text(
                              "• " + product.description.split("\n")[i],
                              style:
                                  const TextStyle().copyWith(color: kTextColor),
                            ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFADABAB),
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 20, 19),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Row(
                            children: const [
                              Text(
                                "Отзывы",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          color: kLightGreyColor[0],
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                product.rating.toString(),
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12),
                              RatingBar(
                                filledColor: kSecondaryColor,
                                currentRating: product.rating.floor(),
                                maxRating: 5,
                                size: 18,
                              ),
                              const SizedBox(width: 17),
                              Text(
                                "${product.feedbacksCount.toString()} Ratings & Reviews",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                    letterSpacing: 0.5 * 0.16),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 23),
                        for (int i = 0; i < 1; i++)
                          if (i != 0)
                            Column(
                              children: [
                                const SizedBox(height: 40),
                                FeedbackCard(feedback: product.feedbacks[i]),
                              ],
                            )
                          else
                            FeedbackCard(feedback: product.feedbacks[i]),
                        const SizedBox(height: 28),
                        RichText(
                          text: TextSpan(
                            text: "View all",
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: VIEW ALL
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFADABAB),
                    thickness: 1,
                  ),
                  if (product.crossProducts.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TitleAndProducts(
                            title: "Похожие товары",
                            products: product.crossProducts),
                      ],
                    ),
                  if (product.recommendationProducts.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TitleAndProducts(
                            title: "Вместе с этим покупают",
                            products: product.recommendationProducts),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
