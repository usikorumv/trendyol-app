import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/models/products/product_present.dart';
import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';

import 'feedback.dart';
import 'product_color.dart';
import 'product_size.dart';
import 'question.dart';

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
  final String showSize;
  final String showColor;
  final List<ProductColor>? colors;
  final List<ProductSize>? sizes;
  final int feedbacksCount;
  final List<Feedback> feedbacks;
  final List<Question> questions;
  final List<ProductPresent> crossProducts;
  final List<ProductPresent> recommendationProducts;

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
    required this.showSize,
    required this.showColor,
    this.colors,
    this.sizes,
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
    String? showSize,
    String? showColor,
    List<ProductColor>? colors,
    List<ProductSize>? sizes,
    int? feedbacksCount,
    List<Feedback>? feedbacks,
    List<Question>? questions,
    List<ProductPresent>? crossProducts,
    List<ProductPresent>? recommendationProducts,
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
      showSize: showSize ?? this.showSize,
      showColor: showColor ?? this.showColor,
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
    result.addAll({'showSize': showSize});
    result.addAll({'showColor': showColor});
    if (colors != null) {
      result.addAll({'colors': colors!.map((x) => x.toMap()).toList()});
    }
    if (sizes != null) {
      result.addAll({'sizes': sizes!.map((x) => x.toMap()).toList()});
    }
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
      showSize: map['showSize'] ?? '',
      showColor: map['showColor'] ?? '',
      sizes: List<ProductSize>.from(
          map['sizes']?.map((x) => ProductSize.fromMap(x))),
      colors: map['colors'] != null
          ? List<ProductColor>.from(
              map['colors']?.map((x) => ProductColor.fromMap(x)))
          : null,
      feedbacksCount: map['feedbacksCount']?.toInt() ?? 0,
      feedbacks: List<Feedback>.from(
          map['feedbacks']?.map((x) => Feedback.fromMap(x))),
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      crossProducts: List<ProductPresent>.from(
          map['crossProducts']?.map((x) => ProductPresent.fromMap(x))),
      recommendationProducts: List<ProductPresent>.from(
          map['recommendationProducts']?.map((x) => ProductPresent.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  factory Product.fromProductRaw(
          ProductRaw rawProduct,
          List<ProductPresent> crossProducts,
          List<ProductPresent> recommendationProducts) =>
      Product(
        id: rawProduct.id,
        imageUrls: rawProduct.images,
        discountedPrice: rawProduct.discountedPrice,
        sellingPrice: rawProduct.sellingPrice,
        originalPrice: rawProduct.originalPrice,
        name: rawProduct.name,
        campaign: rawProduct.campaign,
        description: rawProduct.description,
        rating: rawProduct.rating,
        showSize: rawProduct.showSize,
        showColor: rawProduct.color,
        // TODO: Add sizes
        sizes: const [],
        // sizes: rawProduct.sizes.map((size) => ProductSize.fromSize(size)),
        // TODO: Add color
        colors: const [],
        // colors: rawProduct.colors.map((color) => ProductColor.fromColor),
        // TODO: Add feedbacks
        feedbacksCount: 0,
        feedbacks: const [],
        // feedbacksCount: rawProduct.reviews.length,
        // feedbacks: rawProduct.reviews,
        // TODO: Add questions
        questions: const [],
        // TODO: Store just id
        crossProducts: crossProducts,
        // TODO: Store just id
        recommendationProducts: recommendationProducts,
      );

  @override
  String toString() {
    return 'Product(id: $id, imageUrls: $imageUrls, discountedPrice: $discountedPrice, sellingPrice: $sellingPrice, originalPrice: $originalPrice, name: $name, campaign: $campaign, description: $description, rating: $rating, showColor: $showColor, showSize: $showSize, colors: $colors, sizes: $sizes, feedbacksCount: $feedbacksCount, feedbacks: $feedbacks, questions: $questions, crossProducts: $crossProducts, recommendationProducts: $recommendationProducts)';
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
      showSize,
      showColor,
      colors ?? [],
      sizes ?? [],
      feedbacksCount,
      feedbacks,
      questions,
      crossProducts,
      recommendationProducts,
    ];
  }
}
