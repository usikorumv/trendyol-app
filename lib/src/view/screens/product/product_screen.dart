import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:trendyol_market/src/logic/blocs/product/product_bloc.dart';

import 'package:trendyol_market/src/view/components/rating_bar.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/constants/styles.dart';

import 'package:trendyol_market/src/view/screens/product/widgets/feedback_card.dart';
import 'package:trendyol_market/src/view/screens/product/widgets/title_and_products.dart';
import 'package:trendyol_market/src/view/screens/product/widgets/title_and_widget.dart';

import '../../../data/repository/products_repository.dart';
import '../../../models/product/product.dart';
import 'widgets/product_image_options.dart';
import 'widgets/product_size_option.dart';

// TODO: REFACTOR

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late int _currentProductColorID, _currentProductSizeID;

  @override
  Widget build(BuildContext context) {
    _currentProductColorID = 0;
    _currentProductSizeID = 0;

    return BlocProvider(
      create: (context) => ProductBloc(
        RepositoryProvider.of<ProductsService>(context),
      )..add(
          LoadProduct(id: widget.productId),
        ),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          
          if (state is ProductLoading) {
            return const Scaffold(
              backgroundColor: kPrimaryColor,
              body: CircularProgressIndicator(),
            );
          }

          if (state is ProductLoaded) {
            Product product = state.product;
            print("AFFPFAPAFPF");
            print(product);
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
      ),
    );
  }

  Widget content(Product product) => Scaffold(
        backgroundColor: kPrimaryColor,
        bottomNavigationBar: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: kPrimaryColor,
          padding: EdgeInsets.only(left: 12, right: 4),
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
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: kSecondaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Добавить в корзину",
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
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 600,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
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
                            : const Icon(
                                Icons.favorite_outline_rounded,
                                size: 30,
                              );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_rounded,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: Image.network(
                  //     product.imageUrls[0], // ABOBA
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ];
            },
            body: SingleChildScrollView(
              // controller: controller,
              child: Container(
                color: kPrimaryColor,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 11),
                          Row(
                            children: [
                              RatingBar(
                                currentRating: product.rating.ceil(),
                                maxRating: 5,
                                filledColor: kSecondaryColor,
                              ),
                              SizedBox(width: 7.19),
                              Text(
                                "|  Коментарии (${product.feedbacksCount})",
                                style: TextStyle(
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (product.colors!.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          TitleAndWidget(
                            title: "Цвет",
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < product.colors!.length;
                                      i++)
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: ProductImageOption(
                                        id: i,
                                        imgUrl: product.imageUrls[0], //BABABA
                                        onTap: (index) =>
                                            _currentProductColorID,
                                        isSelected: _currentProductColorID == i,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        TitleAndWidget(
                          title: "Размер",
                          child: // TODO: MAKE SIZE CHOOSING AND CHANGE STATES BY CLICKING THEM
                              SingleChildScrollView(
                            padding: EdgeInsets.only(left: 20),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < product.sizes.length; i++)
                                  Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: ProductSizeOption(
                                        id: i,
                                        currentID: _currentProductSizeID,
                                        size: product.sizes[i].name, //BABABA
                                        onTap: (index) =>
                                            _currentProductColorID = index,
                                        inStock: product.sizes[i].inStock,
                                      )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13),
                    Divider(
                      color: Color(0xFFADABAB),
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 21, 20, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Описание",
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 23),
                          for (int i = 0;
                              i < product.description.split("\n").length;
                              i++)
                            if (i != product.description.split("\n").length - 1)
                              Column(
                                children: [
                                  Text(
                                    "• " + product.description.split("\n")[i],
                                    style:
                                        TextStyle().copyWith(color: kTextColor),
                                  ),
                                  SizedBox(height: 21),
                                ],
                              )
                            else
                              Text(
                                "• " + product.description.split("\n")[i],
                                style: TextStyle().copyWith(color: kTextColor),
                              ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xFFADABAB),
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 20, 20, 19),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
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
                          SizedBox(height: 7),
                          Container(
                            color: kLightGreyColor[0],
                            padding: EdgeInsets.symmetric(vertical: 22),
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  product.rating.toString(),
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 12),
                                RatingBar(
                                  filledColor: kSecondaryColor,
                                  currentRating: product.rating.floor(),
                                  maxRating: 5,
                                  size: 18,
                                ),
                                SizedBox(width: 17),
                                Text(
                                  "${product.feedbacksCount.toString()} Ratings & Reviews",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: kTextColor,
                                      letterSpacing: 0.5 * 0.16),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(height: 23),
                          for (int i = 0; i < 1; i++)
                            if (i != 0)
                              Column(
                                children: [
                                  SizedBox(height: 40),
                                  FeedbackCard(feedback: product.feedbacks[i]),
                                ],
                              )
                            else
                              FeedbackCard(feedback: product.feedbacks[i]),
                          SizedBox(height: 28),
                          RichText(
                            text: TextSpan(
                              text: "View all",
                              style: TextStyle(
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
                    Divider(
                      color: Color(0xFFADABAB),
                      thickness: 1,
                    ),
                    if (product.crossProducts.length > 0)
                      Column(
                        children: [
                          SizedBox(height: 20),
                          TitleAndProducts(
                              title: "Похожие товары",
                              products: product.crossProducts),
                        ],
                      ),
                    if (product.recommendationProducts.length > 0)
                      Column(
                        children: [
                          SizedBox(height: 20),
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
