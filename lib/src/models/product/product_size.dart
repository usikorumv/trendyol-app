import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductSize extends Equatable {
  final String name;
  final String slug;
  final String currency;
  final bool inStock;
  final double value;

  ProductSize({
    required this.name,
    required this.slug,
    required this.currency,
    required this.inStock,
    required this.value,
  });

  ProductSize copyWith({
    String? name,
    String? slug,
    String? currency,
    bool? inStock,
    double? value,
  }) {
    return ProductSize(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      currency: currency ?? this.currency,
      inStock: inStock ?? this.inStock,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'slug': slug});
    result.addAll({'currency': currency});
    result.addAll({'inStock': inStock});
    result.addAll({'value': value});

    return result;
  }

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      currency: map['currency'] ?? '',
      inStock: map['inStock'] ?? false,
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSize.fromJson(String source) =>
      ProductSize.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductSize(name: $name, slug: $slug, currency: $currency, inStock: $inStock, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductSize &&
        other.name == name &&
        other.slug == slug &&
        other.inStock == inStock;
  }

  @override
  int get hashCode => name.hashCode ^ slug.hashCode ^ inStock.hashCode;

  @override
  List<Object> get props {
    return [
      name,
      slug,
      currency,
      inStock,
      value,
    ];
  }
}
