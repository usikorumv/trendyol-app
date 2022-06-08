import 'dart:convert';

import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String slug;
  final List<Category>? children;

  Category({
    required this.name,
    required this.slug,
    this.children,
  });

  bool get isNotParent => children == null;

  Category copyWith({
    String? name,
    String? slug,
    List<Category>? children,
  }) {
    return Category(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'slug': slug});
    if(children != null){
      result.addAll({'children': children!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      children: map['children'] != null ? List<Category>.from(map['children']?.map((x) => Category.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(name: $name, slug: $slug, children: $children)';

  @override
  List<Object> get props => [name, slug, children!];
}
