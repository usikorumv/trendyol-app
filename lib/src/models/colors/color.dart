import 'dart:convert';

class Color {
  final String slug;
  final String title;
  Color({
    required this.slug,
    required this.title,
  });

  Color copyWith({
    String? slug,
    String? title,
  }) {
    return Color(
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

  factory Color.fromMap(Map<String, dynamic> map) {
    return Color(
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Color.fromJson(String source) => Color.fromMap(json.decode(source));

  @override
  String toString() => 'Color(slug: $slug, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Color && other.slug == slug && other.title == title;
  }

  @override
  int get hashCode => slug.hashCode ^ title.hashCode;
}
