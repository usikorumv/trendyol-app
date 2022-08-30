import 'dart:convert';

import 'package:equatable/equatable.dart';
// ignore: unused_import
import 'package:trendyol_market/src/models/products/product_raw/color.dart';

import 'product.dart';

class ProductColor extends Equatable {
  final String name;
  final String slug;
  final Product product;

  const ProductColor({
    required this.name,
    required this.slug,
    required this.product,
  });

  ProductColor copyWith({
    String? name,
    String? slug,
    Product? product,
  }) {
    return ProductColor(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'product': product.toMap()});

    return result;
  }

  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductColor.fromJson(String source) =>
      ProductColor.fromMap(json.decode(source));

  // TODO: Add factory fromColor
  // factory ProductColor.fromColor(Color color) => ProductColor(
  //       name: name,
  //       slug: slug,
  //       product: product,
  //     );

  @override
  String toString() =>
      'ProductColor(name: $name, slug: $slug, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductColor &&
        other.name == name &&
        other.product == product;
  }

  @override
  int get hashCode => name.hashCode ^ product.hashCode;

  @override
  List<Object> get props => [name, slug, product];
}
