import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';
import 'package:trendyol_market/src/view/screens/home/pages/home/widgets/product_counter.dart';

import '../../../../product/product_screen.dart';

class CartListTileWidget extends StatelessWidget {
  const CartListTileWidget({
    Key? key,
    required this.product,
    required this.amount,
    required this.onDelete,
    required this.onRemove,
    required this.onAdd,
  }) : super(key: key);

  final Product product;
  final int amount;
  final Function(int) onDelete, onRemove, onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(productId: product.id),
              ));
        },
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: 180,
            child: Row(
              children: [
                SizedBox(
                    height: 170,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          product.imageUrls[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210,
                            height: 70,
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          IconButton(
                              iconSize: 30,
                              padding: const EdgeInsets.only(left: 10),
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                onDelete(product.id);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 30,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Доставка: ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                          TextSpan(
                              text: "20-25 дней",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold))
                        ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Размер: ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                          TextSpan(
                              text: product.showSize,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold))
                        ])),
                        const SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              ProductCounter(
                                amount: amount,
                                onIncrease: () {
                                  onAdd(product.id);
                                },
                                onDecrease: () {
                                  onRemove(product.id);
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: product.originalPrice.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(
                                        text: " tmt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: product.sellingPrice.toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(
                                        text: " tmt",
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ListTile(isThreeLine: true,
// //dense: true,
// leading: SizedBox(
// height: 150,
// width: 80,
// child: Image.network(
// 'https://i.stack.imgur.com/zXU6v.png',
// fit: BoxFit.cover,
// )),
// title: const Text(
// 'Collection T-shirt - black regular wqwasjhasjkdhaksjdh'),
// subtitle: SizedBox(
// width: 200,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Text('Доставка:20-дней'),
// const Text('Размер:37'),
// const SizedBox(
// height: 10,
// ),
// SizedBox(
// width: 290,
// child: Row(
// children: [
// const ProductCounter(),
// Column(
// children: const [
// Text(
// '61.99 tmt',
// style: TextStyle(
// fontSize: 14,
// decoration: TextDecoration.lineThrough,
// fontWeight: FontWeight.bold),
// ),
// Text(
// '22.21 tmt',
// style: TextStyle(
// color: Colors.orange,
// fontSize: 18,
// fontWeight: FontWeight.bold),
// ),
// ],
// )
// ],
// ),
// )
// ],
// ),
// ),
// trailing: IconButton(
// onPressed: () {},
// icon: const Icon(
// Icons.delete_outline,
// color: Colors.red,
// ),
// ),
// )
//
