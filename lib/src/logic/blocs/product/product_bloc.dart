import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/products_repository.dart';
import 'package:trendyol_market/src/models/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsService _productsService;

  ProductBloc(this._productsService) : super(ProductLoading()) {
    on<LoadProduct>((event, emit) async {
      // try {
      final Product product = await _productsService.fetchProduct(event.id);
      print(product);
      emit(ProductLoaded(product: product));
      // } catch (e) {
      //   print(e);
      //   emit(ProductError());
      // }
    });
  }
}
