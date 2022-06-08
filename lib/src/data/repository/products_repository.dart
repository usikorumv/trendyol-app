import 'package:trendyol_market/src/data/provider/products_provider.dart';
import 'package:trendyol_market/src/models/product/feedback.dart';
import 'package:trendyol_market/src/models/product_raw/review.dart';
import 'package:trendyol_market/src/models/product/product.dart';
import 'package:trendyol_market/src/models/product/product_size.dart';
import 'package:trendyol_market/src/models/product_raw/product_raw.dart';

class ProductsService {
  final ProductsApiClient productsApiClient;

  ProductsService({required this.productsApiClient});

  Future<Product> fetchProduct(int id) async {
    ProductRaw rawProduct = await productsApiClient.fetchProduct(id);

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
        sizes: rawProduct.sizes
            .map((size) => ProductSize(
                  name: size.value.toUpperCase(),
                  slug: size.value,
                  inStock: size.inStock,
                  currency: '',
                  value: size.price,
                ))
            .toList(),
        feedbacksCount: 0,
        // feedbacksCount: reviews.length,
        feedbacks: [],
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
        questions: [],
        crossProducts: [],
        recommendationProducts: [] //  rawRecommendationProducts.map((product) =>
        //   Product(imageUrls: pro, discountedPrice: discountedPrice, sell ingPrice: sellingPrice, originalPrice: originalPrice, name: name, campaign: campaign, description: description, rating: rating, startProductSize: startProductSize, sizes: sizes, feedbacksCount: feedbacksCount, feedbacks: feedbacks, questions: questions, crossProducts: crossProducts, recommendationProducts: recommendationProducts)
        // ).toList(),
        );

    return product;
  }

  Future<List<ProductPresent>> fetchProducts() async {
    List<ProductPresent> products = [];

    List<ProductRaw> rawProducts = await productsApiClient.fetchProducts();
    print(rawProducts);

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
}
