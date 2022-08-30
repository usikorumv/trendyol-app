import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/models/products/product_present_raw.dart';

class ProductPresent extends Equatable {
  final int id;
  final String imageUrl;
  final String campaign;
  final String name;
  final double discountedPrice;
  final double sellingPrice;
  final double originalPrice;
  final int feedbacksCount;
  final double rating;

  const ProductPresent({
    required this.id,
    required this.imageUrl,
    required this.campaign,
    required this.name,
    required this.discountedPrice,
    required this.sellingPrice,
    required this.originalPrice,
    required this.feedbacksCount,
    required this.rating,
  });

  ProductPresent copyWith({
    int? id,
    String? imageUrl,
    String? campaign,
    String? name,
    double? discountedPrice,
    double? sellingPrice,
    double? originalPrice,
    int? feedbacksCount,
    double? rating,
  }) {
    return ProductPresent(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      campaign: campaign ?? this.campaign,
      name: name ?? this.name,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      feedbacksCount: feedbacksCount ?? this.feedbacksCount,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'campaign': campaign});
    result.addAll({'name': name});
    result.addAll({'discountedPrice': discountedPrice});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'originalPrice': originalPrice});
    result.addAll({'feedbacksCount': feedbacksCount});
    result.addAll({'rating': rating});

    return result;
  }

  factory ProductPresent.fromMap(Map<String, dynamic> map) {
    return ProductPresent(
      id: map['id']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      campaign: map['campaign'] ?? '',
      name: map['name'] ?? '',
      discountedPrice: map['discountedPrice']?.toDouble() ?? 0.0,
      sellingPrice: map['sellingPrice']?.toDouble() ?? 0.0,
      originalPrice: map['originalPrice']?.toDouble() ?? 0.0,
      feedbacksCount: map['feedbacksCount']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPresent.fromJson(String source) =>
      ProductPresent.fromMap(json.decode(source));

  factory ProductPresent.fromProductPresentRaw(
          ProductPresentRaw rawPresentProduct) =>
      ProductPresent(
        id: rawPresentProduct.id,
        imageUrl: rawPresentProduct.images.isNotEmpty
            ? rawPresentProduct.images[0]
            : "",
        campaign: rawPresentProduct.campaign,
        name: rawPresentProduct.name,
        discountedPrice: rawPresentProduct.discountedPrice,
        sellingPrice: rawPresentProduct.sellingPrice,
        originalPrice: rawPresentProduct.originalPrice,
        feedbacksCount: rawPresentProduct.feedbacksCount,
        rating: rawPresentProduct.rating,
      );

  @override
  String toString() {
    return 'ProductPresent(id: $id, imageUrl: $imageUrl, campaign: $campaign, name: $name, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, feedbacksCount: $feedbacksCount, rating: $rating)';
  }

  @override
  List<Object> get props {
    return [
      id,
      imageUrl,
      campaign,
      name,
      discountedPrice,
      sellingPrice,
      originalPrice,
      feedbacksCount,
      rating,
    ];
  }
}
