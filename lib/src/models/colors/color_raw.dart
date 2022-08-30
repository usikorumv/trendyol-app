import 'dart:convert';

class ColorRaw {
  final String slug;
  final String name;
  ColorRaw({
    required this.slug,
    required this.name,
  });

  ColorRaw copyWith({
    String? slug,
    String? name,
  }) {
    return ColorRaw(
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

  factory ColorRaw.fromMap(Map<String, dynamic> map) {
    return ColorRaw(
      slug: map['slug'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorRaw.fromJson(String source) =>
      ColorRaw.fromMap(json.decode(source));

  @override
  String toString() => 'ColorRaw(slug: $slug, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorRaw && other.slug == slug && other.name == name;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode;
}
