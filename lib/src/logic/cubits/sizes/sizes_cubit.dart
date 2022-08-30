import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';

import '../../../models/sizes/size.dart';

part 'sizes_state.dart';

class SizesCubit extends Cubit<SizesState> {
  final TrendyolService _productsService;

  SizesCubit(this._productsService) : super(SizesInitial());

  loadSizes() async {
    try {
      emit(SizesLoadind());

      List<Size> sizes = await _productsService.getSizes();

      emit(SizesLoaded(sizes: sizes));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(SizesError());
    }
  }
}
