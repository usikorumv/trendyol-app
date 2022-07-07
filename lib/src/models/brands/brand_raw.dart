import 'dart:convert';

class BrandRaw {
  final String slug;
  final String brand;
  BrandRaw({
    required this.slug,
    required this.brand,
  });

  BrandRaw copyWith({
    String? slug,
    String? brand,
  }) {
    return BrandRaw(
      slug: slug ?? this.slug,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'slug': slug});
    result.addAll({'brand': brand});
  
    return result;
  }

  factory BrandRaw.fromMap(Map<String, dynamic> map) {
    return BrandRaw(
      slug: map['slug'] ?? '',
      brand: map['brand'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandRaw.fromJson(String source) => BrandRaw.fromMap(json.decode(source));

  @override
  String toString() => 'BrandRaw(slug: $slug, brand: $brand)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BrandRaw &&
      other.slug == slug &&
      other.brand == brand;
  }

  @override
  int get hashCode => slug.hashCode ^ brand.hashCode;
}
