import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'size.dart';

class ProductRaw extends Equatable {
  int id;
  List<String> images;
  String name;
  String description;
  String link;
  double discountedPrice;
  double sellingPrice;
  double originalPrice;
  String campaign;
  String currency;
  String user;
  String category;
  dynamic parent;
  String color;
  String showSize;
  String brand;
  int reviews;
  int likes;
  List<Size> sizes;
  double rating;

  ProductRaw({
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.link,
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
    required this.reviews,
    required this.likes,
    required this.sizes,
    required this.rating,
  });


  ProductRaw copyWith({
    int? id,
    List<String>? images,
    String? name,
    String? description,
    String? link,
    double? discountedPrice,
    double? sellingPrice,
    double? originalPrice,
    String? campaign,
    String? currency,
    String? user,
    String? category,
    dynamic? parent,
    String? color,
    String? showSize,
    String? brand,
    int? reviews,
    int? likes,
    List<Size>? sizes,
    double? rating,
  }) {
    return ProductRaw(
      id: id ?? this.id,
      images: images ?? this.images,
      name: name ?? this.name,
      description: description ?? this.description,
      link: link ?? this.link,
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
      reviews: reviews ?? this.reviews,
      likes: likes ?? this.likes,
      sizes: sizes ?? this.sizes,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'images': images});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'link': link});
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
    result.addAll({'reviews': reviews});
    result.addAll({'likes': likes});
    result.addAll({'sizes': sizes.map((x) => x.toMap()).toList()});
    result.addAll({'rating': rating});
  
    return result;
  }

  factory ProductRaw.fromMap(Map<String, dynamic> map) {
    return ProductRaw(
      id: map['id']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      link: map['link'] ?? '',
      discountedPrice: map['discountedPrice']?.toDouble() ?? 0.0,
      sellingPrice: map['sellingPrice']?.toDouble() ?? 0.0,
      originalPrice: map['originalPrice']?.toDouble() ?? 0.0,
      campaign: map['campaign'] ?? '',
      currency: map['currency'] ?? '',
      user: map['user'] ?? '',
      category: map['category'] ?? '',
      parent: map['parent'] ?? null,
      color: map['color'] ?? '',
      showSize: map['showSize'] ?? '',
      brand: map['brand'] ?? '',
      reviews: map['reviews']?.toInt() ?? 0,
      likes: map['likes']?.toInt() ?? 0,
      sizes: List<Size>.from(map['sizes']?.map((x) => Size.fromMap(x))),
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRaw.fromJson(String source) => ProductRaw.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductRaw(id: $id, images: $images, name: $name, description: $description, link: $link, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, campaign: $campaign, currency: $currency, user: $user, category: $category, parent: $parent, color: $color, showSize: $showSize, brand: $brand, reviews: $reviews, likes: $likes, sizes: $sizes, rating: $rating)';
  }

  @override
  List<Object> get props {
    return [
      id,
      images,
      name,
      description,
      link,
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
      reviews,
      likes,
      sizes,
      rating,
    ];
  }
}
