import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/params.dart';
import 'package:trendyol_market/src/models/products/product_present.dart';

part 'present_products_event.dart';
part 'present_products_state.dart';

class PresentProductsBloc
    extends Bloc<PresentProductsEvent, PresentProductsState> {
  final TrendyolService _productsService;

  late int currentPage;
  late Params params;

  // ignore: prefer_final_fields
  List<ProductPresent> _presentProducts = [];
  List<ProductPresent> get presentProducts => _presentProducts;

  PresentProductsBloc(this._productsService) : super(PresentProductsInitial()) {
    on<LoadPresentProducts>((event, emit) async {
      try {
        emit(PresentProductsLoading());

        currentPage = 1;
        params = event.params;
        _presentProducts.clear();

        final List<ProductPresent> products = await _productsService
            .getPresentProducts(currentPage, params: params, pageSize: 8);

        _presentProducts.addAll(products);

        emit(PresentProductsLoaded());
      } catch (e, s) {
        log(e.toString());
        log(s.toString());

        emit(PresentProductsError());
      }
    });

    on<NextProductsPageEvent>((event, emit) async {
      try {
        emit(PresentProductsLoading());

        currentPage += 1;

        final List<ProductPresent> products = await _productsService
            .getPresentProducts(currentPage, params: params, pageSize: 4);

        if (products.isEmpty) {
          emit(PresentProductsEmpty());
        } else {
          _presentProducts.addAll(products);
          emit(PresentProductsLoaded());
        }
      } catch (e, s) {
        log(e.toString());
        log(s.toString());

        emit(PresentProductsError());
      }
    }, transformer: restartable());
  }
}
