import 'dart:convert';

import 'package:trendyol_market/src/models/products/product/product.dart';

class ProductCart {
  final int id;
  final Product product;
  int amount;

  ProductCart({
    required this.id,
    required this.product,
    this.amount = 1,
  });

  ProductCart copyWith({
    int? id,
    Product? product,
    int? amount,
  }) {
    return ProductCart(
      id: id ?? this.id,
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'product': product.toMap()});
    result.addAll({'amount': amount});
  
    return result;
  }

  factory ProductCart.fromMap(Map<String, dynamic> map) {
    return ProductCart(
      id: map['id']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCart.fromJson(String source) =>
      ProductCart.fromMap(json.decode(source));

  @override
  String toString() => 'ProductCart(id: $id, product: $product, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductCart &&
      other.id == id &&
      other.product == product &&
      other.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode ^ amount.hashCode;
}
