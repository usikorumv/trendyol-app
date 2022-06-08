import 'package:equatable/equatable.dart';

import 'size.dart';

class ProductRaw extends Equatable {
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

  factory ProductRaw.fromJson(Map<String, dynamic> json) => ProductRaw(
        id: json["id"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        description: json["description"],
        link: json["link"],
        discountedPrice: json["discounted_price"].toDouble(),
        sellingPrice: json["selling_price"].toDouble(),
        originalPrice: json["original_price"].toDouble(),
        campaign: json["campaign"],
        currency: json["currency"],
        user: json["user"],
        category: json["category"],
        parent: json["parent"],
        color: json["color"],
        showSize: json["show_size"],
        brand: json["brand"],
        reviews: json["reviews"],
        likes: json["likes"],
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "description": description,
        "link": link,
        "discounted_price": discountedPrice,
        "selling_price": sellingPrice,
        "original_price": originalPrice,
        "campaign": campaign,
        "currency": currency,
        "user": user,
        "category": category,
        "parent": parent,
        "color": color,
        "show_size": showSize,
        "brand": brand,
        "reviews": reviews,
        "likes": likes,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        "rating": rating,
      };

  @override
  List<Object?> get props => [
        id,
        name,
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
