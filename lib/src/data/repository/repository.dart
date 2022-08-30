// ignore_for_file: unused_import

import 'package:trendyol_market/src/data/provider/trendyol_provider.dart';
import 'package:trendyol_market/src/models/brands/brand.dart';
import 'package:trendyol_market/src/models/brands/brand_raw.dart';
import 'package:trendyol_market/src/models/categories/category.dart';
import 'package:trendyol_market/src/models/categories/category_raw.dart';
import 'package:trendyol_market/src/models/colors/color.dart';
import 'package:trendyol_market/src/models/colors/color_raw.dart';
import 'package:trendyol_market/src/models/params.dart';
import 'package:trendyol_market/src/models/products/product/feedback.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';
import 'package:trendyol_market/src/models/products/product/product_size.dart';
import 'package:trendyol_market/src/models/products/product/question.dart';
import 'package:trendyol_market/src/models/products/product_present.dart';
import 'package:trendyol_market/src/models/products/product_present_raw.dart';
import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart_raw.dart';
import 'package:trendyol_market/src/models/sizes/size.dart';
import 'package:trendyol_market/src/models/sizes/size_raw.dart';

class TrendyolService {
  final TrendyolApiClient trendyolApiClient;

  TrendyolService({required this.trendyolApiClient});

  Future<Product> getProduct(int id) async {
    ProductRaw rawProduct = await trendyolApiClient.fetchProduct(id);

    // List<Review> reviews = await productsApiClient.fetchReviews(rawProduct.id);

    // List<ProductRaw> rawRecommendationProducts =
    //     await productsApiClient.fetchRecommendationProducts(rawProduct.id);

    // TODO: Add method for getting cross products

    // TODO: Add cross and recommendation products
    Product product = Product.fromProductRaw(rawProduct, const [], const []);

    return product;
  }

  Future<List<ProductPresent>> getPresentProducts(int page,
      {Params params = const Params(), pageSize = 10}) async {
    List<ProductPresentRaw> rawPresentProducts = await trendyolApiClient
        .fetchPresentProducts(params, page, pageSize: pageSize);

    List<ProductPresent> presentProducts = rawPresentProducts
        .map((rawPresentProduct) =>
            ProductPresent.fromProductPresentRaw(rawPresentProduct))
        .toList();

    return presentProducts;
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    List<CategoryRaw> rawCategories = await trendyolApiClient.fetchCategories();

    for (var rawCategory in rawCategories) {
      categories.add(Category(
        slug: rawCategory.slug,
        title: rawCategory.title,
        filter: rawCategory.filter_f,
        parent: rawCategory.parent,
      ));
    }

    return categories;
  }

  Future<List<Brand>> getBrands() async {
    List<Brand> brands = [];

    List<BrandRaw> rawBrands = await trendyolApiClient.fetchBrands();

    for (var rawBrand in rawBrands) {
      brands.add(Brand(
        slug: rawBrand.slug,
        title: rawBrand.name,
      ));
    }

    return brands;
  }

  Future<List<Color>> getColors() async {
    List<Color> colors = [];

    List<ColorRaw> rawColors = await trendyolApiClient.fetchColors();

    for (var rawColor in rawColors) {
      colors.add(Color(
        slug: rawColor.slug,
        title: rawColor.name,
      ));
    }

    return colors;
  }

  Future<List<Size>> getSizes() async {
    List<Size> sizes = [];

    List<SizeRaw> rawSizes = await trendyolApiClient.fetchSizes();

    for (var rawSize in rawSizes) {
      sizes.add(Size(
        slug: rawSize.slug,
        title: rawSize.size,
      ));
    }

    return sizes;
  }

  Future<List<ProductCart>> getCartProducts() async {
    List<ProductCart> cartProducts = [];

    List<ProductCartRaw> rawCartProducts =
        await trendyolApiClient.fetchCartProducts();

    for (ProductCartRaw rawCartProduct in rawCartProducts) {
      ProductCart productCart = ProductCart(
          id: rawCartProduct.id,
          product: await getProduct(rawCartProduct.id),
          amount: rawCartProduct.quantity);

      cartProducts.add(productCart);
    }

    return cartProducts;
  }

  Future addToCart(int id, String size) async {
    await trendyolApiClient.addToCart(id, size);
  }

  Future removeFromCart(int id) async {
    await trendyolApiClient.removeFromCart(id);
  }
}
