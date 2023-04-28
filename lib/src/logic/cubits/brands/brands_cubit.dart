import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/brands/brand.dart';

part 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final TrendyolService _productsService;

  BrandsCubit(this._productsService) : super(BrandsInitial());

  loadBrands() async {
    try {
      emit(BrandsLoading());

      List<Brand> brands = await _productsService.getBrands();

      emit(BrandsLoaded(brands: brands));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(BrandsError());
    }
  }
}
