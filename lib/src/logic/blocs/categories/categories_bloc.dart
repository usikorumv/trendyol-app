import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/products_repository.dart';
import '../../../models/categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsService _productsService;

  CategoriesBloc(this._productsService) : super(CategoriesInitial()) {
    on<LoadCategories>((event, emit) async {
      // try {
      emit(CategoriesLoading());

      final List<Category> categories = await _productsService.getCategories();

      emit(CategoriesLoaded(categories: categories));
      // } catch (e) {
      //   print(e);
      //   emit(CategoriesError());
      // }
    });
  }
}
