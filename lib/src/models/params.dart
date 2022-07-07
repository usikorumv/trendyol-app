import 'dart:convert';

class Params {
  final String name;
  final String priceFrom;
  final String priceTo;
  final String category;
  final String brand;
  final String filter;
  final String search;

  const Params({
    this.name = "",
    this.priceFrom = "",
    this.priceTo = "",
    this.category = "",
    this.brand = "",
    this.filter = "",
    this.search = "",
  });

  Params copyWithMap(Map<String, String> map) {
    return Params(
      name: map['name'] ?? name,
      priceFrom: map['priceFrom'] ?? priceFrom,
      priceTo: map['priceTo'] ?? priceTo,
      category: map['category'] ?? category,
      brand: map['brand'] ?? brand,
      filter: map['filter'] ?? filter,
      search: map['search'] ?? search,
    );
  }

  Params removeFromMap(Map<String, String> map) {
    return Params(
      name: map.containsKey("name") ? '' : name,
      priceFrom: map.containsKey("priceFrom") ? '' : priceFrom,
      priceTo: map.containsKey("priceTo") ? '' : priceTo,
      category: map.containsKey("category") ? '' : category,
      brand: map.containsKey("brand") ? '' : brand,
      filter: map.containsKey("filter") ? '' : filter,
      search: map.containsKey("search") ? '' : search,
    );
  }

  Params copyWith({
    String? name,
    String? priceFrom,
    String? priceo,
    String? category,
    String? brand,
    String? filter,
    String? search,
  }) {
    return Params(
      name: name ?? this.name,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceo ?? this.priceTo,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      filter: filter ?? this.filter,
      search: search ?? this.search,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'priceFrom': priceFrom});
    result.addAll({'priceo': priceTo});
    result.addAll({'category': category});
    result.addAll({'brand': brand});
    result.addAll({'filter': filter});
    result.addAll({'search': search});

    return result;
  }

  String toFilter() {
    return toString().replaceAll(RegExp(": "), "=").replaceAll(", ", "&");
  }

  factory Params.fromMap(Map<String, dynamic> map) {
    return Params(
      name: map['name'] ?? '',
      priceFrom: map['priceFrom'] ?? '',
      priceTo: map['priceTo'] ?? '',
      category: map['category'] ?? '',
      brand: map['brand'] ?? '',
      filter: map['filter'] ?? '',
      search: map['search'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Params.fromJson(String source) => Params.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Params(name: $name, priceFrom: $priceFrom, priceTo: $priceTo, category: $category, brand: $brand, filter: $filter, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Params &&
        other.name == name &&
        other.priceFrom == priceFrom &&
        other.priceTo == priceTo &&
        other.category == category &&
        other.brand == brand &&
        other.filter == filter &&
        other.search == search;
  }

  bool get isEmpty {
    return name.isEmpty &&
        priceFrom.isEmpty &&
        priceTo.isEmpty &&
        category.isEmpty &&
        brand.isEmpty &&
        filter.isEmpty &&
        search.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        priceFrom.hashCode ^
        priceTo.hashCode ^
        category.hashCode ^
        brand.hashCode ^
        filter.hashCode ^
        search.hashCode;
  }
}
