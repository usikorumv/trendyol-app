import 'dart:convert';

class ColorRaw {
  final String slug;
  final String color;
  ColorRaw({
    required this.slug,
    required this.color,
  });

  ColorRaw copyWith({
    String? slug,
    String? color,
  }) {
    return ColorRaw(
      slug: slug ?? this.slug,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'slug': slug});
    result.addAll({'color': color});
  
    return result;
  }

  factory ColorRaw.fromMap(Map<String, dynamic> map) {
    return ColorRaw(
      slug: map['slug'] ?? '',
      color: map['color'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorRaw.fromJson(String source) => ColorRaw.fromMap(json.decode(source));

  @override
  String toString() => 'ColorRaw(slug: $slug, color: $color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorRaw &&
      other.slug == slug &&
      other.color == color;
  }

  @override
  int get hashCode => slug.hashCode ^ color.hashCode;
}
