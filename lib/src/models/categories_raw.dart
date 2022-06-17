import 'dart:convert';

class CategoryRaw {
  String slug;
  String title;
  String filter_f;
  String parent;

  CategoryRaw({
    required this.slug,
    required this.title,
    required this.filter_f,
    required this.parent,
  });

  CategoryRaw copyWith({
    String? slug,
    String? title,
    String? filter_f,
    String? parent,
  }) {
    return CategoryRaw(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      filter_f: filter_f ?? this.filter_f,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'slug': slug});
    result.addAll({'title': title});
    result.addAll({'filter_f': filter_f});
    result.addAll({'parent': parent});

    return result;
  }

  factory CategoryRaw.fromMap(Map<String, dynamic> map) {
    return CategoryRaw(
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
      filter_f: map['filter_f'] ?? '',
      parent: map['parent'] ?? 'root',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryRaw.fromJson(String source) =>
      CategoryRaw.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoriesRaw(slug: $slug, title: $title, filter_f: $filter_f, parent: $parent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryRaw &&
        other.slug == slug &&
        other.title == title &&
        other.filter_f == filter_f &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    return slug.hashCode ^ title.hashCode ^ filter_f.hashCode ^ parent.hashCode;
  }
}
