

import 'package:equatable/equatable.dart';

class Size extends Equatable {
  Size({
    required this.id,
    required this.inStock,
    required this.price,
    required this.currency,
    required this.user,
    required this.product,
    required this.value,
  });

  int id;
  bool inStock;
  double price;
  String currency;
  String user;
  int product;
  String value;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        inStock: json["in_stock"],
        price: json["price"].toDouble(),
        currency: json["currency"],
        user: json["user"],
        product: json["product"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_stock": inStock,
        "price": price,
        "currency": currency,
        "user": user,
        "product": product,
        "value": value,
      };

  @override
  List<Object?> get props => [
        id,
        inStock,
        price,
        currency,
        user,
        product,
        value,
      ];
}
