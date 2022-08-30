import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/repository.dart';
import '../../../models/categories/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final TrendyolService _productsService;

  CategoriesBloc(this._productsService) : super(CategoriesInitial()) {
    on<LoadCategories>((event, emit) async {
      try {
        emit(CategoriesLoading());

        final List<Category> categories =
            await _productsService.getCategories();

        emit(CategoriesLoaded(categories: categories));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(CategoriesError());
      }
    });
  }
}
