import 'dart:convert';

class SizeRaw {
  final String slug;
  final String size;
  SizeRaw({
    required this.slug,
    required this.size,
  });

  SizeRaw copyWith({
    String? slug,
    String? size,
  }) {
    return SizeRaw(
      slug: slug ?? this.slug,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'slug': slug});
    result.addAll({'size': size});
  
    return result;
  }

  factory SizeRaw.fromMap(Map<String, dynamic> map) {
    return SizeRaw(
      slug: map['slug'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeRaw.fromJson(String source) => SizeRaw.fromMap(json.decode(source));

  @override
  String toString() => 'SizeRaw(slug: $slug, size: $size)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SizeRaw &&
      other.slug == slug &&
      other.size == size;
  }

  @override
  int get hashCode => slug.hashCode ^ size.hashCode;
}
