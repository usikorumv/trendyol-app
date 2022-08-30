import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final TrendyolService _productsService;

  ProductBloc(this._productsService) : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      try {
        emit(ProductLoading());

        final Product product = await _productsService.getProduct(event.id);

        emit(ProductLoaded(product: product));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(ProductError());
      }
    });
  }
}
