import 'dart:convert';

class Category {
  String slug;
  String title;
  String filter;
  String parent;

  Category({
    required this.slug,
    required this.title,
    required this.filter,
    required this.parent,
  });

  Category copyWith({
    String? slug,
    String? title,
    String? filter,
    String? parent,
  }) {
    return Category(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      filter: filter ?? this.filter,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'slug': slug});
    result.addAll({'title': title});
    result.addAll({'filter': filter});
    result.addAll({'parent': parent});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
      filter: map['filter'] ?? '',
      parent: map['parent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Categories(slug: $slug, title: $title, filter: $filter, parent: $parent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.slug == slug &&
        other.title == title &&
        other.filter == filter &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    return slug.hashCode ^ title.hashCode ^ filter.hashCode ^ parent.hashCode;
  }
}
