import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';

import '../../../models/products_cart/product_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Service _productsService;

  List<Product> cartProducts = [];

  CartBloc(this._productsService) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      try {
        emit(CartLoading());

        List<ProductCart> products = await _productsService.getCartProducts();

        cartProducts =
            products.map((cartProduct) => cartProduct.product).toList();

        if (products.isNotEmpty) {
          emit(CartLoaded(products: products));
        } else {
          emit(CartEmpty());
        }
      } catch (e) {
        log(e.toString());
        emit(CartLoadError());
      }
    });

    on<RemoveFromCart>((event, emit) async {
      try {
        emit(CartRemoving());

        await _productsService.removeFromCart(event.product.id);

        cartProducts.remove(event.product);

        emit(CartRemoved());
      } catch (e) {
        log(e.toString());
        emit(CartRemoveError());
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        emit(CartAdding());

        await _productsService.addToCart(event.product.id, event.size);

        cartProducts.add(event.product);

        emit(CartAdded());
      } catch (e) {
        log(e.toString());
        emit(CartAddError());
      }
    });
  }
}
