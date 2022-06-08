import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/products_repository.dart';
import 'package:trendyol_market/src/models/product/product.dart';

part 'present_products_event.dart';
part 'present_products_state.dart';

class PresentProductsBloc
    extends Bloc<PresentProductsEvent, PresentProductsState> {
  final ProductsService _productsService;

  PresentProductsBloc(this._productsService) : super(PresentProductsLoading()) {
    on<LoadPresentProductsEvent>((event, emit) async {
      // try {
        final List<ProductPresent> products =
            await _productsService.fetchProducts();
        emit(PresentProductsLoaded(products: products));
      // } catch (e) {
      //   print(e);
      //   emit(PresentProductsError());
      // }
    });
  }
}
