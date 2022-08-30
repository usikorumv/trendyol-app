import 'dart:convert';

class Params {
  final String name;
  final String priceFrom;
  final String priceTo;
  final String category;
  final String brand;
  final String search;

  const Params({
    this.name = "",
    this.priceFrom = "",
    this.priceTo = "",
    this.category = "",
    this.brand = "",
    this.search = "",
  });

  Params copyWithMap(Map<String, String> map) {
    return Params(
      name: map['name'] ?? name,
      priceFrom: map['price_from'] ?? priceFrom,
      priceTo: map['price_to'] ?? priceTo,
      category: map['category'] ?? category,
      brand: map['brand'] ?? brand,
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
      search: map.containsKey("search") ? '' : search,
    );
  }

  Params copyWith({
    String? name,
    String? priceFrom,
    String? priceTo,
    String? category,
    String? brand,
    String? filter,
    String? search,
  }) {
    return Params(
      name: name ?? this.name,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      search: search ?? this.search,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'priceFrom': priceFrom});
    result.addAll({'priceTo': priceTo});
    result.addAll({'category': category});
    result.addAll({'brand': brand});
    result.addAll({'search': search});

    return result;
  }

  String toFilter() {
    List<String> filter = [];

    List<String> filterList =
        toString().substring(7).replaceFirst(")", "").split(", ");

    for (int i = 0; i < filterList.length; i++) {
      String param = filterList[i];

      if (param.substring(param.indexOf(":") + 1).length > 1) {
        filter.add(param.replaceAll(": ", "="));
      }
    }

    return filter.join("&");
  }

  factory Params.fromMap(Map<String, dynamic> map) {
    return Params(
      name: map['name'] ?? '',
      priceFrom: map['priceFrom'] ?? '',
      priceTo: map['priceTo'] ?? '',
      category: map['category'] ?? '',
      brand: map['brand'] ?? '',
      search: map['search'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Params.fromJson(String source) => Params.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Params(name: $name, price_from: $priceFrom, price_to: $priceTo, category: $category, brand: $brand, search: $search)';
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
        other.search == search;
  }

  bool get isEmpty {
    return name.isEmpty &&
        priceFrom.isEmpty &&
        priceTo.isEmpty &&
        category.isEmpty &&
        brand.isEmpty &&
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
        search.hashCode;
  }
}
