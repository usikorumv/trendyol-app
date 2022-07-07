import 'dart:convert';

class Brand {
  final String slug;
  final String title;
  Brand({
    required this.slug,
    required this.title,
  });

  Brand copyWith({
    String? slug,
    String? title,
  }) {
    return Brand(
      slug: slug ?? this.slug,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'slug': slug});
    result.addAll({'title': title});
  
    return result;
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  String toString() => 'Brand(slug: $slug, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Brand &&
      other.slug == slug &&
      other.title == title;
  }

  @override
  int get hashCode => slug.hashCode ^ title.hashCode;
}
