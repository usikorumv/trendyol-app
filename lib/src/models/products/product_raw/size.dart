import 'dart:convert';

import 'package:equatable/equatable.dart';

class Size extends Equatable {
  int id;
  bool inStock;
  double price;
  String currency;
  String user;
  int product;
  String value;
  Size({
    required this.id,
    required this.inStock,
    required this.price,
    required this.currency,
    required this.user,
    required this.product,
    required this.value,
  });

  Size copyWith({
    int? id,
    bool? inStock,
    double? price,
    String? currency,
    String? user,
    int? product,
    String? value,
  }) {
    return Size(
      id: id ?? this.id,
      inStock: inStock ?? this.inStock,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      user: user ?? this.user,
      product: product ?? this.product,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'inStock': inStock});
    result.addAll({'price': price});
    result.addAll({'currency': currency});
    result.addAll({'user': user});
    result.addAll({'product': product});
    result.addAll({'value': value});
  
    return result;
  }

  factory Size.fromMap(Map<String, dynamic> map) {
    return Size(
      id: map['id']?.toInt() ?? 0,
      inStock: map['inStock'] ?? false,
      price: map['price']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? '',
      user: map['user'] ?? '',
      product: map['product']?.toInt() ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Size.fromJson(String source) => Size.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Size(id: $id, inStock: $inStock, price: $price, currency: $currency, user: $user, product: $product, value: $value)';
  }

  @override
  List<Object> get props {
    return [
      id,
      inStock,
      price,
      currency,
      user,
      product,
      value,
    ];
  }
}
