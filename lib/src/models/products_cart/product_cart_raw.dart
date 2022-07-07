import 'dart:convert';

import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';

class ProductCartRaw {
  final int id;
  final int quantity;
  final ProductRaw product;
  
  ProductCartRaw({
    required this.id,
    required this.quantity,
    required this.product,
  });

  ProductCartRaw copyWith({
    int? id,
    int? quantity,
    ProductRaw? product,
  }) {
    return ProductCartRaw(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'quantity': quantity});
    result.addAll({'product': product.toMap()});
  
    return result;
  }

  factory ProductCartRaw.fromMap(Map<String, dynamic> map) {
    return ProductCartRaw(
      id: map['id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      product: ProductRaw.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCartRaw.fromJson(String source) => ProductCartRaw.fromMap(json.decode(source));

  @override
  String toString() => 'ProductCartRaw(id: $id, quantity: $quantity, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductCartRaw &&
      other.id == id &&
      other.quantity == quantity &&
      other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode ^ product.hashCode;
}
