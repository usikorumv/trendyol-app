import 'package:trendyol_market/src/models/categories/category_raw.dart';
import 'package:trendyol_market/src/models/brands/brand_raw.dart';
import 'package:trendyol_market/src/models/colors/color_raw.dart';
import 'package:trendyol_market/src/models/sizes/size_raw.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart_raw.dart';
import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';
import 'package:trendyol_market/src/models/products/product_raw/review.dart';
import 'package:trendyol_market/src/models/params.dart';

import 'package:http/http.dart' as http;

// List<ProductRaw> rawProducts = [];

// var url = Uri.parse(api);
// http.Response response = await http.get(url);

// if (response.statusCode == 200) {
//   var data = json.decode(response.body);

//   List products = data["products"];
//   rawProducts = products.map((product) => ProductRaw.fromJson(product)).toList();
// } else {
//   print(response.statusCode);
// }

// return rawProducts;

class TrendyolApiClient {
  Future<ProductRaw> fetchProduct(int id) async {
    ProductRaw rawProduct = ProductRaw.fromJson(
        r'{"id": 1,"images": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-SCue-TSPX9aCauDsxtmhhKm8N65bq2RAnQ&usqp=CAU"],"name": "Erkek Siyah Desenli Pamuklu Yazlık Kısa Kollu","description": "Numune ölçüleri: 175 boy 72 kilo m beden. %70 pamuk. Ürünün kalıbı normal slimdir. Kendi bedeninizden 1 bedeb buyuk almanız tavsıye edılır. Çekimlerde renkler ışık farklılığından dolayı değişiklik gösterebilir.\nBu üründen en fazla 10 adet sipariş verilebilir. 10 adetin üzerindeki siparişleri Trendyol iptal etme hakkını saklı tutar.\nKampanya fiyatından satılmak üzere 100 adetten fazla stok sunulmuştur.\nİncelemiş olduğunuz ürünün satış fiyatını satıcı belirlemektedir.\nBir ürün, birden fazla satıcı tarafından satılabilir. Birden fazla satıcı tarafından satışa sunulan ürünlerin satıcıları ürün için belirledikleri fiyata, satıcı puanlarına, teslimat statülerine, ürünlerdeki promosyonlara, kargonun bedava olup olmamasına ve ürünlerin hızlı teslimat ile teslim edilip edilememesine, ürünlerin stok ve kategorileri bilgilerine göre sıralanmaktadır.","link": "/the-brands-4/erkek-siyah-desenli-pamuklu-yazlik-kisa-kollu-p-134123465","discounted_price": 125,"selling_price": 139,"original_price": 110,"campaign": "MAX FASHİON","currency": "TRY","user": "b@gmail.com","category": "gomlek","parent": null,"color": "haki","show_size": "l","brand": "no-brand","reviews": 0,"likes": 0,"sizes": [{"id": 66680,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "s"},{"id": 66681,"in_stock": false,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "m"},{"id": 66682,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "l"},{"id": 66683,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xl"},{"id": 66684,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xxl"}],"rating": 0}');

    await Future.delayed(const Duration(seconds: 2));

    return rawProduct;
  }

  Future<List<ProductRaw>> fetchProducts(Params params) async {
    List<ProductRaw> rawProducts = <ProductRaw>[
      ProductRaw.fromJson(
          r'{"id": 1,"images": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-SCue-TSPX9aCauDsxtmhhKm8N65bq2RAnQ&usqp=CAU"],"name": "Erkek Siyah Desenli Pamuklu Yazlık Kısa Kollu","description": "Numune ölçüleri: 175 boy 72 kilo m beden. %70 pamuk. Ürünün kalıbı normal slimdir. Kendi bedeninizden 1 bedeb buyuk almanız tavsıye edılır. Çekimlerde renkler ışık farklılığından dolayı değişiklik gösterebilir.\nBu üründen en fazla 10 adet sipariş verilebilir. 10 adetin üzerindeki siparişleri Trendyol iptal etme hakkını saklı tutar.\nKampanya fiyatından satılmak üzere 100 adetten fazla stok sunulmuştur.\nİncelemiş olduğunuz ürünün satış fiyatını satıcı belirlemektedir.\nBir ürün, birden fazla satıcı tarafından satılabilir. Birden fazla satıcı tarafından satışa sunulan ürünlerin satıcıları ürün için belirledikleri fiyata, satıcı puanlarına, teslimat statülerine, ürünlerdeki promosyonlara, kargonun bedava olup olmamasına ve ürünlerin hızlı teslimat ile teslim edilip edilememesine, ürünlerin stok ve kategorileri bilgilerine göre sıralanmaktadır.","link": "/the-brands-4/erkek-siyah-desenli-pamuklu-yazlik-kisa-kollu-p-134123465","discounted_price": 125,"selling_price": 139,"original_price": 110,"campaign": "MAX FASHİON","currency": "TRY","user": "b@gmail.com","category": "gomlek","parent": null,"color": "haki","show_size": "s","brand": "no-brand","reviews": 0,"likes": 0,"sizes": [{"id": 66680,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "s"},{"id": 66681,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "m"},{"id": 66682,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "l"},{"id": 66683,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xl"},{"id": 66684,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xxl"}],"rating": 0}'),
    ];

    await Future.delayed(const Duration(seconds: 2));

    return rawProducts;
  }

  Future<List<Review>> fetchReviews(int productId) async {
    List<Review> reviews = [
      Review.fromJson(""""{id": 1,
        "user": "dani@gmail.com",
        "comment": "тема",
        "product": 267481227}"""),
    ];

    await Future.delayed(const Duration(seconds: 2));

    return reviews;
  }

  Future<List<ProductRaw>> fetchRecommendationProducts(int id) async {
    List<ProductRaw> rawProducts = [
      ProductRaw.fromJson("""{"id": 134123465,
            "images": [],
            "name": "Erkek Siyah Desenli Pamuklu Yazlık Kısa Kollu",
            "description": "Numune ölçüleri: 175 boy 72 kilo m beden. %70 pamuk. Ürünün kalıbı normal slimdir. Kendi bedeninizden 1 bedeb buyuk almanız tavsıye edılır. Çekimlerde renkler ışık farklılığından dolayı değişiklik gösterebilir.\nBu üründen en fazla 10 adet sipariş verilebilir. 10 adetin üzerindeki siparişleri Trendyol iptal etme hakkını saklı tutar.\nKampanya fiyatından satılmak üzere 100 adetten fazla stok sunulmuştur.\nİncelemiş olduğunuz ürünün satış fiyatını satıcı belirlemektedir.\nBir ürün, birden fazla satıcı tarafından satılabilir. Birden fazla satıcı tarafından satışa sunulan ürünlerin satıcıları ürün için belirledikleri fiyata, satıcı puanlarına, teslimat statülerine, ürünlerdeki promosyonlara, kargonun bedava olup olmamasına ve ürünlerin hızlı teslimat ile teslim edilip edilememesine, ürünlerin stok ve kategorileri bilgilerine göre sıralanmaktadır.",
            "link": "/the-brands-4/erkek-siyah-desenli-pamuklu-yazlik-kisa-kollu-p-134123465",
            "discounted_price": 125,
            "selling_price": 139,
            "original_price": 110,
            "campaign": "MAX FASHİON",
            "currency": "TRY",
            "user": "b@gmail.com",
            "category": "gomlek",
            "parent": null,
            "color": "haki",
            "show_size": "s",
            "brand": "no-brand",
            "reviews": 0,
            "likes": 0,
            "sizes": [
                {
                    "id": 66680,
                    "in_stock": true,
                    "price": 115,
                    "currency": "TRY",
                    "user": "b@gmail.com",
                    "product": 134123465,
                    "value": "s"
                },
                {
                    "id": 66681,
                    "in_stock": true,
                    "price": 115,
                    "currency": "TRY",
                    "user": "b@gmail.com",
                    "product": 134123465,
                    "value": "m"
                },
                {
                    "id": 66682,
                    "in_stock": true,
                    "price": 115,
                    "currency": "TRY",
                    "user": "b@gmail.com",
                    "product": 134123465,
                    "value": "l"
                },
                {
                    "id": 66683,
                    "in_stock": true,
                    "price": 115,
                    "currency": "TRY",
                    "user": "b@gmail.com",
                    "product": 134123465,
                    "value": "xl"
                },
                {
                    "id": 66684,
                    "in_stock": true,
                    "price": 115,
                    "currency": "TRY",
                    "user": "b@gmail.com",
                    "product": 134123465,
                    "value": "xxl"
                }
            ],
            "rating": 0}"""),
    ];

    await Future.delayed(Duration(seconds: 2));

    return rawProducts;
  }

  Future<List<CategoryRaw>> fetchCategories() async {
    List<CategoryRaw> rawCategories = [
      CategoryRaw.fromJson(
          '{"slug": "kadın-giyim", "title": "Tesettür Pareo","filter_f": "kadın-giyim"}'),
      CategoryRaw.fromJson(
          '{"slug": "tesettur-pareo","title": "Tesettür Pareo","filter_f": "kadın-giyim --> tesettur-giyim-tesettur-pareo","parent": "kadın-giyim"}'),
    ];

    await Future.delayed(Duration(seconds: 2));

    return rawCategories;
  }

  Future<List<BrandRaw>> fetchBrands() async {
    List<BrandRaw> rawBrands = [
      BrandRaw.fromJson(
          '{"slug": "mh-moony-homewears","brand": "mh-moony-homewears"},')
    ];

    await Future.delayed(Duration(seconds: 2));

    return rawBrands;
  }

  Future<List<ColorRaw>> fetchColors() async {
    List<ColorRaw> rawColors = [
      ColorRaw.fromJson(
          '{"slug": "mh-moony-homewears","brand": "mh-moony-homewears"},')
    ];

    await Future.delayed(Duration(seconds: 2));

    return rawColors;
  }

  Future<List<SizeRaw>> fetchSizes() async {
    List<SizeRaw> rawSizes = [SizeRaw.fromJson('{"slug": "x", "size": "X"}')];

    await Future.delayed(Duration(seconds: 2));

    return rawSizes;
  }

  List<ProductCartRaw> rawCartProducts = [];

  Future<List<ProductCartRaw>> fetchCartProducts() async {
    await Future.delayed(Duration(seconds: 2));

    return rawCartProducts;
  }

  Future addToCart(int id, String size) async {
    rawCartProducts.add(ProductCartRaw(
        id: rawCartProducts.length + 1,
        quantity: 1,
        product: ProductRaw.fromJson(
            r'{"id": 1,"images": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-SCue-TSPX9aCauDsxtmhhKm8N65bq2RAnQ&usqp=CAU"],"name": "Erkek Siyah Desenli Pamuklu Yazlık Kısa Kollu","description": "Numune ölçüleri: 175 boy 72 kilo m beden. %70 pamuk. Ürünün kalıbı normal slimdir. Kendi bedeninizden 1 bedeb buyuk almanız tavsıye edılır. Çekimlerde renkler ışık farklılığından dolayı değişiklik gösterebilir.\nBu üründen en fazla 10 adet sipariş verilebilir. 10 adetin üzerindeki siparişleri Trendyol iptal etme hakkını saklı tutar.\nKampanya fiyatından satılmak üzere 100 adetten fazla stok sunulmuştur.\nİncelemiş olduğunuz ürünün satış fiyatını satıcı belirlemektedir.\nBir ürün, birden fazla satıcı tarafından satılabilir. Birden fazla satıcı tarafından satışa sunulan ürünlerin satıcıları ürün için belirledikleri fiyata, satıcı puanlarına, teslimat statülerine, ürünlerdeki promosyonlara, kargonun bedava olup olmamasına ve ürünlerin hızlı teslimat ile teslim edilip edilememesine, ürünlerin stok ve kategorileri bilgilerine göre sıralanmaktadır.","link": "/the-brands-4/erkek-siyah-desenli-pamuklu-yazlik-kisa-kollu-p-134123465","discounted_price": 125,"selling_price": 139,"original_price": 110,"campaign": "MAX FASHİON","currency": "TRY","user": "b@gmail.com","category": "gomlek","parent": null,"color": "haki","show_size": "s","brand": "no-brand","reviews": 0,"likes": 0,"sizes": [{"id": 66680,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "s"},{"id": 66681,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "m"},{"id": 66682,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "l"},{"id": 66683,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xl"},{"id": 66684,"in_stock": true,"price": 115,"currency": "TRY","user": "b@gmail.com","product": 134123465,"value": "xxl"}],"rating": 0}')));

    await Future.delayed(Duration(seconds: 2));
  }

  Future removeFromCart(int id) async {
    rawCartProducts.removeWhere((cartProduct) => cartProduct.product.id == id);

    await Future.delayed(Duration(seconds: 2));
  }
}
