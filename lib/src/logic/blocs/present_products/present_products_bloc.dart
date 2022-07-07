import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/params.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';

part 'present_products_event.dart';
part 'present_products_state.dart';

class PresentProductsBloc
    extends Bloc<PresentProductsEvent, PresentProductsState> {
  final Service _productsService;

  PresentProductsBloc(this._productsService) : super(PresentProductsInitial()) {
    on<LoadPresentProducts>((event, emit) async {
      try {
        emit(PresentProductsLoading());

        final List<ProductPresent> products =
            await _productsService.getProducts(params: Params());

        emit(PresentProductsLoaded(products: products));
      } catch (e) {
        log(e.toString());
        emit(PresentProductsError());
      }
    });
  }
}
