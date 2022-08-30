import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductPresentRaw extends Equatable {
  final int id;
  final List<String> images;
  final String campaign;
  final String name;
  final double discountedPrice;
  final double sellingPrice;
  final double originalPrice;
  final int feedbacksCount;
  final double rating;

  const ProductPresentRaw({
    required this.id,
    required this.images,
    required this.campaign,
    required this.name,
    required this.discountedPrice,
    required this.sellingPrice,
    required this.originalPrice,
    required this.feedbacksCount,
    required this.rating,
  });

  ProductPresentRaw copyWith({
    int? id,
    List<String>? images,
    String? campaign,
    String? name,
    double? discountedPrice,
    double? sellingPrice,
    double? originalPrice,
    int? feedbacksCount,
    double? rating,
  }) {
    return ProductPresentRaw(
      id: id ?? this.id,
      images: images ?? this.images,
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
    result.addAll({'images': images});
    result.addAll({'campaign': campaign});
    result.addAll({'name': name});
    result.addAll({'discountedPrice': discountedPrice});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'originalPrice': originalPrice});
    result.addAll({'feedbacksCount': feedbacksCount});
    result.addAll({'rating': rating});

    return result;
  }

  factory ProductPresentRaw.fromMap(Map<String, dynamic> map) {
    return ProductPresentRaw(
      id: map['id']?.toInt() ?? 0,
      images: (map['images'] as List)
          .map(
            (image) => image["url"] as String,
          )
          .toList(),
      campaign: map['campaign'] ?? '',
      name: map['name'] ?? '',
      discountedPrice: map['discounted_price']?.toDouble() ?? 0.0,
      sellingPrice: map['selling_price']?.toDouble() ?? 0.0,
      originalPrice: map['original_price']?.toDouble() ?? 0.0,
      feedbacksCount: map['reviews']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPresentRaw.fromJson(String source) =>
      ProductPresentRaw.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductPresentRaw(id: $id, images: $images, campaign: $campaign, name: $name, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, feedbacksCount: $feedbacksCount, rating: $rating)';
  }

  @override
  List<Object> get props {
    return [
      id,
      images,
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
