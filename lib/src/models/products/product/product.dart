import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feedback.dart';
import 'product_color.dart';
import 'product_size.dart';
import 'question.dart';

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

  ProductPresent({
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

  factory ProductPresent.fromProduct(Product product) {
    return ProductPresent(
      id: product.id,
      imageUrl: product.imageUrls[0],
      campaign: product.campaign,
      name: product.name,
      discountedPrice: product.discountedPrice,
      sellingPrice: product.sellingPrice,
      originalPrice: product.originalPrice,
      feedbacksCount: product.feedbacksCount,
      rating: product.rating,
    );
  }

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

class Product extends Equatable {
  final int id;
  final List<String> imageUrls;
  final double discountedPrice;
  final double sellingPrice;
  final double originalPrice;
  final String name;
  final String campaign;
  final String description;
  final double rating;
  final ProductColor? startProductColor;
  final String startProductSize;
  final List<ProductColor>? colors;
  final List<ProductSize> sizes;
  final int feedbacksCount;
  final List<Feedback> feedbacks;
  final List<Question> questions;
  final List<Product> crossProducts;
  final List<Product> recommendationProducts;

  const Product({
    required this.id,
    required this.imageUrls,
    required this.discountedPrice,
    required this.sellingPrice,
    required this.originalPrice,
    required this.name,
    required this.campaign,
    required this.description,
    required this.rating,
    this.startProductColor,
    required this.startProductSize,
    this.colors,
    required this.sizes,
    required this.feedbacksCount,
    required this.feedbacks,
    required this.questions,
    required this.crossProducts,
    required this.recommendationProducts,
  });

  Product copyWith({
    int? id,
    List<String>? imageUrls,
    double? discountedPrice,
    double? sellingPrice,
    double? originalPrice,
    String? name,
    String? campaign,
    String? description,
    double? rating,
    ProductColor? startProductColor,
    String? startProductSize,
    List<ProductColor>? colors,
    List<ProductSize>? sizes,
    int? feedbacksCount,
    List<Feedback>? feedbacks,
    List<Question>? questions,
    List<Product>? crossProducts,
    List<Product>? recommendationProducts,
  }) {
    return Product(
      id: id ?? this.id,
      imageUrls: imageUrls ?? this.imageUrls,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      name: name ?? this.name,
      campaign: campaign ?? this.campaign,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      startProductColor: startProductColor ?? this.startProductColor,
      startProductSize: startProductSize ?? this.startProductSize,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      feedbacksCount: feedbacksCount ?? this.feedbacksCount,
      feedbacks: feedbacks ?? this.feedbacks,
      questions: questions ?? this.questions,
      crossProducts: crossProducts ?? this.crossProducts,
      recommendationProducts:
          recommendationProducts ?? this.recommendationProducts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imageUrls': imageUrls});
    result.addAll({'discountedPrice': discountedPrice});
    result.addAll({'sellingPrice': sellingPrice});
    result.addAll({'originalPrice': originalPrice});
    result.addAll({'name': name});
    result.addAll({'campaign': campaign});
    result.addAll({'description': description});
    result.addAll({'rating': rating});
    if (startProductColor != null) {
      result.addAll({'startProductColor': startProductColor!.toMap()});
    }
    result.addAll({'startProductSize': startProductSize});
    if (colors != null) {
      result.addAll({'colors': colors!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'sizes': sizes.map((x) => x.toMap()).toList()});
    result.addAll({'feedbacksCount': feedbacksCount});
    result.addAll({'feedbacks': feedbacks.map((x) => x.toMap()).toList()});
    result.addAll({'questions': questions.map((x) => x.toMap()).toList()});
    result.addAll(
        {'crossProducts': crossProducts.map((x) => x.toMap()).toList()});
    result.addAll({
      'recommendationProducts':
          recommendationProducts.map((x) => x.toMap()).toList()
    });

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      imageUrls: List<String>.from(map['imageUrls']),
      discountedPrice: map['discountedPrice']?.toDouble() ?? 0.0,
      sellingPrice: map['sellingPrice']?.toDouble() ?? 0.0,
      originalPrice: map['originalPrice']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      campaign: map['campaign'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      startProductColor: map['startProductColor'] != null
          ? ProductColor.fromMap(map['startProductColor'])
          : null,
      startProductSize: map['startProductSize'] ?? '',
      colors: map['colors'] != null
          ? List<ProductColor>.from(
              map['colors']?.map((x) => ProductColor.fromMap(x)))
          : null,
      sizes: List<ProductSize>.from(
          map['sizes']?.map((x) => ProductSize.fromMap(x))),
      feedbacksCount: map['feedbacksCount']?.toInt() ?? 0,
      feedbacks: List<Feedback>.from(
          map['feedbacks']?.map((x) => Feedback.fromMap(x))),
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      crossProducts: List<Product>.from(
          map['crossProducts']?.map((x) => Product.fromMap(x))),
      recommendationProducts: List<Product>.from(
          map['recommendationProducts']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, imageUrls: $imageUrls, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, name: $name, campaign: $campaign, description: $description, rating: $rating, startProductColor: $startProductColor, startProductSize: $startProductSize, colors: $colors, sizes: $sizes, feedbacksCount: $feedbacksCount, feedbacks: $feedbacks, questions: $questions, crossProducts: $crossProducts, recommendationProducts: $recommendationProducts)';
  }

  @override
  List<Object> get props {
    return [
      id,
      imageUrls,
      discountedPrice,
      sellingPrice,
      originalPrice,
      name,
      campaign,
      description,
      rating,
      startProductColor ?? [],
      startProductSize,
      colors ?? [],
      sizes,
      feedbacksCount,
      feedbacks,
      questions,
      crossProducts,
      recommendationProducts,
    ];
  }
}
