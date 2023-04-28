import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:trendyol_market/src/models/products/product_raw/color.dart';

import 'size.dart';

class ProductRaw extends Equatable {
  final int id;
  final String link;
  final List<String> images;
  final String name;
  final String description;
  final double discountedPrice;
  final double sellingPrice;
  final double originalPrice;
  final String campaign;
  final String currency;
  final String user;
  final String category;
  final dynamic parent;
  final String color;
  final String showSize;
  final String brand;
  final int likes;
  final double rating;
  final List<Size> sizes;
  final List<Color> colors;
  final List reviews;

  const ProductRaw({
    required this.id,
    required this.link,
    required this.images,
    required this.name,
    required this.description,
    required this.discountedPrice,
    required this.sellingPrice,
    required this.originalPrice,
    required this.campaign,
    required this.currency,
    required this.user,
    required this.category,
    required this.parent,
    required this.color,
    required this.showSize,
    required this.brand,
    required this.likes,
    required this.rating,
    required this.sizes,
    required this.colors,
    required this.reviews,
  });

  ProductRaw copyWith({
    int? id,
    String? link,
    List<String>? images,
    String? name,
    String? description,
    double? discountedPrice,
    double? sellingPrice,
    double? originalPrice,
    String? campaign,
    String? currency,
    String? user,
    String? category,
    dynamic parent,
    String? color,
    String? showSize,
    String? brand,
    int? likes,
    double? rating,
    List<Size>? sizes,
    List<Color>? colors,
    List? reviews,
  }) {
    return ProductRaw(
      id: id ?? this.id,
      link: link ?? this.link,
      images: images ?? this.images,
      name: name ?? this.name,
      description: description ?? this.description,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      campaign: campaign ?? this.campaign,
      currency: currency ?? this.currency,
      user: user ?? this.user,
      category: category ?? this.category,
      parent: parent ?? this.parent,
      color: color ?? this.color,
      showSize: showSize ?? this.showSize,
      brand: brand ?? this.brand,
      likes: likes ?? this.likes,
      rating: rating ?? this.rating,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'link': link});
    result.addAll({'images': images});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'discountedPrice': discountedPrice});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'originalPrice': originalPrice});
    result.addAll({'campaign': campaign});
    result.addAll({'currency': currency});
    result.addAll({'user': user});
    result.addAll({'category': category});
    result.addAll({'parent': parent});
    result.addAll({'color': color});
    result.addAll({'showSize': showSize});
    result.addAll({'brand': brand});
    result.addAll({'likes': likes});
    result.addAll({'rating': rating});
    result.addAll({'sizes': sizes.map((x) => x.toMap()).toList()});
    result.addAll({'colors': []});
    // TODO: Add colors
    // result.addAll({'colors': colors.map((x) => x.value).toList()});
    result.addAll({'reviews': []});
    // TODO: Add reviews
    // result.addAll({'reviews': reviews.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductRaw.fromMap(Map<String, dynamic> map) {
    return ProductRaw(
      id: map['id']?.toInt() ?? 0,
      link: map['link'] ?? '',
      images: (map['images'] as List)
          .map(
            (image) => image["url"] as String,
          )
          .toList(),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      discountedPrice: map['discounted_price']?.toDouble() ?? 0.0,
      sellingPrice: map['selling_price']?.toDouble() ?? 0.0,
      originalPrice: map['original_price']?.toDouble() ?? 0.0,
      campaign: map['campaign'] ?? '',
      currency: map['currency'] ?? '',
      user: map['user'] ?? '',
      category: map['show_size'] ?? '',
      parent: map['parent'],
      color: map['color'] ?? '',
      showSize: map['showSize'] ?? '',
      brand: map['brand'] ?? '',
      likes: map['likes']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
      sizes: List<Size>.from(map['sizes']?.map((x) => Size.fromMap(x))),
      // TODO: Add colors
      colors: const [],
      // colors: List<Color>.from(map['colors']?.map((x) => Color(x))),
      // TODO: Add reviews
      reviews: const [],
      // reviews: List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRaw.fromJson(String source) =>
      ProductRaw.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductRaw(id: $id, link: $link, images: $images, name: $name, description: $description, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, campaign: $campaign, currency: $currency, user: $user, category: $category, parent: $parent, color: $color, showSize: $showSize, brand: $brand, likes: $likes, rating: $rating, sizes: $sizes, colors: $colors, reviews: $reviews)';
  }

  @override
  List<Object> get props {
    return [
      id,
      link,
      images,
      name,
      description,
      discountedPrice,
      sellingPrice,
      originalPrice,
      campaign,
      currency,
      user,
      category,
      parent,
      color,
      showSize,
      brand,
      likes,
      rating,
      sizes,
      colors,
      reviews,
    ];
  }
}
