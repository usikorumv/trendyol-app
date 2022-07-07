part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoadError extends CartState {}

class CartAddError extends CartState {}

class CartRemoveError extends CartState {}

class CartAdding extends CartState {}

class CartAdded extends CartState {}

class CartAlreadyAdded extends CartState {}

class CartRemoving extends CartState {}

class CartRemoved extends CartState {}

class CartLoaded extends CartState {
  final List<ProductCart> products;

  const CartLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class CartEmpty extends CartState {}