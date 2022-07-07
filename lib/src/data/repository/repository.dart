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
import 'package:trendyol_market/src/models/products/product_raw/product_raw.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart.dart';
import 'package:trendyol_market/src/models/products_cart/product_cart_raw.dart';
import 'package:trendyol_market/src/models/sizes/size.dart';
import 'package:trendyol_market/src/models/sizes/size_raw.dart';

class Service {
  final TrendyolApiClient trendyolApiClient;

  Service({required this.trendyolApiClient});

  Future<Product> getProduct(int id) async {
    ProductRaw rawProduct = await trendyolApiClient.fetchProduct(id);

    // List<Review> reviews = await productsApiClient.fetchReviews(rawProduct.id);

    // List<ProductRaw> rawRecommendationProducts =
    //     await productsApiClient.fetchRecommendationProducts(rawProduct.id);

    Product product = Product(
        id: rawProduct.id,
        imageUrls: rawProduct.images,
        discountedPrice: rawProduct.discountedPrice,
        sellingPrice: rawProduct.sellingPrice,
        originalPrice: rawProduct.originalPrice,
        name: rawProduct.name,
        campaign: rawProduct.name,
        description: rawProduct.description,
        rating: rawProduct.rating,
        startProductSize: rawProduct.showSize,
        // colors: [ProductColor()],
        sizes: rawProduct.sizes
            .map((size) => ProductSize(
                  name: size.value.toUpperCase(),
                  slug: size.value,
                  inStock: size.inStock,
                  currency: size.currency,
                  value: size.price,
                ))
            .toList(),
        feedbacksCount: 0,
        // feedbacksCount: reviews.length,
        feedbacks: const [
          Feedback(
              user: "Baitur",
              comment: "Good deal",
              date: "12.12.2022",
              rating: 4.3,
              likes: 1),
        ],
        // feedbacks: reviews
        //     .map(
        //       (review) => Feedback(
        //         user: review.user,
        //         comment: review.comment,
        //         date: "",
        //         rating: 5,
        //         likes: 1,
        //       ),
        //     )
        //     .toList(),
        questions: const [
          Question(
              user: "Amantur",
              question: "How to play this movei?",
              answer: "You have to read captions")
        ],
        crossProducts: [],
        recommendationProducts: [] //  rawRecommendationProducts.map((product) =>
        //   Product(imageUrls: pro, discountedPrice: discountedPrice, sell ingPrice: sellingPrice, originalPrice: originalPrice, name: name, campaign: campaign, description: description, rating: rating, startProductSize: startProductSize, sizes: sizes, feedbacksCount: feedbacksCount, feedbacks: feedbacks, questions: questions, crossProducts: crossProducts, recommendationProducts: recommendationProducts)
        // ).toList(),
        );

    return product;
  }

  Future<List<ProductPresent>> getProducts(
      {Params params = const Params()}) async {
    List<ProductPresent> products = [];

    List<ProductRaw> rawProducts =
        await trendyolApiClient.fetchProducts(params);

    rawProducts.forEach((rawProduct) async {
      products.add(ProductPresent(
        id: rawProduct.id,
        imageUrl: rawProduct.images[0],
        discountedPrice: rawProduct.discountedPrice,
        sellingPrice: rawProduct.sellingPrice,
        originalPrice: rawProduct.originalPrice,
        name: rawProduct.name,
        campaign: rawProduct.name,
        rating: rawProduct.rating,
        feedbacksCount: 0,
      ));
    });

    return products;
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    List<CategoryRaw> rawCategories = await trendyolApiClient.fetchCategories();

    rawCategories.forEach((rawCategory) {
      categories.add(Category(
        slug: rawCategory.slug,
        title: rawCategory.title,
        filter: rawCategory.filter_f,
        parent: rawCategory.parent,
      ));
    });

    return categories;
  }

  Future<List<Brand>> getBrands() async {
    List<Brand> brands = [];

    List<BrandRaw> rawBrands = await trendyolApiClient.fetchBrands();

    rawBrands.forEach((rawBrand) {
      brands.add(Brand(
        slug: rawBrand.slug,
        title: rawBrand.brand,
      ));
    });

    return brands;
  }

  Future<List<Color>> getColors() async {
    List<Color> colors = [];

    List<ColorRaw> rawColors = await trendyolApiClient.fetchColors();

    rawColors.forEach((rawColor) {
      colors.add(Color(
        slug: rawColor.slug,
        title: rawColor.color,
      ));
    });

    return colors;
  }

  Future<List<Size>> getSizes() async {
    List<Size> sizes = [];

    List<SizeRaw> rawSizes = await trendyolApiClient.fetchSizes();

    rawSizes.forEach((rawSize) {
      sizes.add(Size(
        slug: rawSize.slug,
        title: rawSize.size,
      ));
    });

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
