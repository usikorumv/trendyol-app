import 'dart:convert';

class Size {
  final String slug;
  final String title;
  Size({
    required this.slug,
    required this.title,
  });

  Size copyWith({
    String? slug,
    String? title,
  }) {
    return Size(
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

  factory Size.fromMap(Map<String, dynamic> map) {
    return Size(
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Size.fromJson(String source) => Size.fromMap(json.decode(source));

  @override
  String toString() => 'Size(slug: $slug, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Size &&
      other.slug == slug &&
      other.title == title;
  }

  @override
  int get hashCode => slug.hashCode ^ title.hashCode;
}
