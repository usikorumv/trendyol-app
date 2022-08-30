import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/colors/color.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsState> {
  final TrendyolService _productsService;

  ColorsCubit(this._productsService) : super(ColorsInitial());

  loadColors() async {
     try {
      emit(ColorsLoading());

      List<Color> colors = await _productsService.getColors();

      emit(ColorsLoaded(colors: colors));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(ColorsError());
    }
  }
}
