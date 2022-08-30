import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:trendyol_market/src/data/api.dart';
import 'package:trendyol_market/src/models/categories/category_raw.dart';
import 'package:trendyol_market/src/models/brands/brand_raw.dart';
import 'package:trendyol_market/src/models/colors/color_raw.dart';
import 'package:trendyol_market/src/models/products/product_present_raw.dart';
import 'package:trendyol_market/src/models/sizes/size_raw.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart_raw.dart';
import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';
import 'package:trendyol_market/src/models/params.dart';

class TrendyolApiClient {
  dynamic fetchDataFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<ProductRaw> fetchProduct(int id) async {
    final data = await fetchDataFromUrl(Api.api + "product_cards/$id/");
    final product = data;

    ProductRaw rawProduct = ProductRaw.fromMap(product);

    return rawProduct;
  }

  Future<List<ProductPresentRaw>> fetchPresentProducts(Params params, int page,
      {int pageSize = 10}) async {
    String url = Api.api + "product_cards/?page=$page&page_size=$pageSize";

    if (params.isNotEmpty) {
      url += "&${params.toFilter()}";
    }

    print(url);

    final data = await fetchDataFromUrl(url);

    final products = (data['results'] ?? []) as List;

    List<ProductPresentRaw> rawPresentProducts =
        products.map((product) => ProductPresentRaw.fromMap(product)).toList();

    return rawPresentProducts;
  }

  // TODO: Add reviews
  Future<List> fetchReviews(int productId) async {
    List reviews = [];

    return reviews;
  }

  // TODO: Add recommendationProducts
  Future<List> fetchRecommendationProducts(int id) async {
    List recommedationProducts = [];

    return recommedationProducts;
  }

  Future<List<CategoryRaw>> fetchCategories() async {
    final data = await fetchDataFromUrl(Api.api + "parser/categories-list/");
    final categories = data as List;

    List<CategoryRaw> rawCategories = categories
        .map((rawCategory) => CategoryRaw.fromMap(rawCategory))
        .toList();

    return rawCategories;
  }

  Future<List<BrandRaw>> fetchBrands() async {
    final data = await fetchDataFromUrl(Api.api + "parser/brand-list/");
    final brands = data as List;

    List<BrandRaw> rawBrands =
        brands.map((brand) => BrandRaw.fromMap(brand)).toList();

    return rawBrands;
  }

  Future<List<ColorRaw>> fetchColors() async {
    final data = await fetchDataFromUrl(Api.api + "parser/color-list/");
    final colors = data as List;

    List<ColorRaw> rawColors =
        colors.map((color) => ColorRaw.fromMap(color)).toList();

    return rawColors;
  }

  Future<List<SizeRaw>> fetchSizes() async {
    final data = await fetchDataFromUrl(Api.api + "parser/size-list/");
    final sizes = data as List;

    List<SizeRaw> rawSizes =
        sizes.map((color) => SizeRaw.fromMap(color)).toList();

    return rawSizes;
  }

  List<ProductCartRaw> rawCartProducts = [];

  Future<List<ProductCartRaw>> fetchCartProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return rawCartProducts;
  }

  Future addToCart(int id, String size) async {
    rawCartProducts.add(ProductCartRaw(
        id: rawCartProducts.length + 1,
        quantity: 1,
        product: ProductRaw.fromJson(
            r'{"id": 1,"images": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-SCue-TSPX9aCauDsxtmhhKm8N65bq2RAnQ&usqp=CAU"],"name": "Erkek Siyah Desenli Pamuklu Yazlık Kısa Kollu","description": "Numune ölçüleri: 175 boy 72 kilo m beden. %70 pamuk. Ürünün kalıbı normal slimdir. Kendi bedeninizden 1 bedeb buyuk almanız tavsıye edılır. Çekimlerde renkler ışık farklılığından dolayı değişiklik gösterebilir.\nBu üründen en fazla 10 adet sipariş verilebilir. 10 adetin üzerindeki siparişleri Trendyol iptal etme hakkını saklı tutar.\nKampanya fiyatından satılmak üzere 100 adetten fazla stok sunulmuştur.\nİncelemiş olduğunuz ürünün satış fiyatını satıcı belirlemektedir.\nBir ürün, birden fazla satıcı tarafından satılabilir. Birden fazla satıcı tarafından satışa sunulan ürünlerin satıcıları ürün için belirledikleri fiyata, satıcı puanlarına, teslimat statülerine, ürünlerdeki promosyonlara, kargonun bedava olup olmamasına ve ürünlerin hızlı teslimat ile teslim edilip edilememesine, ürünlerin stok ve kategorileri bilgilerine göre sıralanmaktadır.","link": "/the-brands-4/erkek-siyah-desenli-pamuklu-yazlik-kisa-kollu-p-134123465","discounted_price": 125,"selling_price": 139,"original_price": 110,"campaign": "MAX FASHİON","currency": "TRY","user": "b@gmail.com","category": "gomlek","parent": null,"color": "haki","show_size": "s","brand": "no-brand","reviews": 0,"likes": 0,"sizes": [{"id": 66680,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "s"},{"id": 66681,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "m"},{"id": 66682,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "l"},{"id": 66683,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xl"},{"id": 66684,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xxl"}],"rating": 0}')));

    await Future.delayed(const Duration(seconds: 2));
  }

  Future removeFromCart(int id) async {
    rawCartProducts.removeWhere((cartProduct) => cartProduct.product.id == id);

    await Future.delayed(const Duration(seconds: 2));
  }
}
