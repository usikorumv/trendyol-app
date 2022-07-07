import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/cart/cart_bloc.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';

import '../../../../models/products_cart/product_cart.dart';
import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import 'home/widgets/cart_list_tile.dart';
import 'home/widgets/custom_serch_field.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.id, required this.tabController})
      : super(key: key);

  final int id;
  final CustomTabController tabController;

  static AppBar appBar = AppBar(
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
      child: const CustomSearchField(),
    ),
  );

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double currentPrice = 0;

  bool inPage = false;

  @override
  void initState() {
    super.initState();

    inPage = true;

    context.read<CartBloc>().add(LoadCart());

    widget.tabController.listeners.add(
      (page) {
        if (page == widget.id && inPage) {
          context.read<CartBloc>().add(LoadCart());
          return;
        }

        if (page == widget.id) {
          inPage = true;
        } else {
          inPage = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: _size.height,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Stack(
            children: [
              () {
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CartLoaded) {
                  var products = state.products;

                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        ProductCart cartProduct = products[index];

                        currentPrice += 10;

                        return CartListTileWidget(
                          product: cartProduct.product,
                          amount: cartProduct.amount,
                          onDelete: (id) {
                            setState(() {
                              context.read<CartBloc>().add(
                                  RemoveFromCart(product: cartProduct.product));

                              context.read<CartBloc>().add(LoadCart());
                            });
                          },
                          onAdd: (id) {
                            setState(() {
                              currentPrice += state.products
                                  .firstWhere((cartProduct) =>
                                      id == cartProduct.product.id)
                                  .product
                                  .sellingPrice;
                            });
                          },
                          onRemove: (id) {
                            setState(() {
                              currentPrice -= state.products
                                  .firstWhere((cartProduct) =>
                                      id == cartProduct.product.id)
                                  .product
                                  .sellingPrice;
                            });
                          },
                        );
                      });
                }

                if (state is CartEmpty) {
                  return Center(
                    child: Text(
                      "Cart is Empty",
                      style: TextStyle(
                        color: kLightGreyColor[3],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  );
                }

                return Center(
                  child: Column(
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
                      ),
                    ],
                  ),
                );
              }(),
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
                        children: [
                          const Text(
                            "Итого",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "$currentPrice tmp",
                            style: kSellingPriceTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: currentPrice > 0
                                ? kLightGreyColor[0]
                                : kSecondaryColor,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
