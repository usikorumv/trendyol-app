import 'dart:convert';

class BrandRaw {
  final String slug;
  final String name;
  BrandRaw({
    required this.slug,
    required this.name,
  });

  BrandRaw copyWith({
    String? slug,
    String? name,
  }) {
    return BrandRaw(
      slug: slug ?? this.slug,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'slug': slug});
    result.addAll({'name': name});

    return result;
  }

  factory BrandRaw.fromMap(Map<String, dynamic> map) {
    return BrandRaw(
      slug: map['slug'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandRaw.fromJson(String source) =>
      BrandRaw.fromMap(json.decode(source));

  @override
  String toString() => 'BrandRaw(slug: $slug, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandRaw && other.slug == slug && other.name == name;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode;
}
