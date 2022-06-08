part of 'present_products_bloc.dart';

abstract class PresentProductsState extends Equatable {
  const PresentProductsState();

  @override
  List<Object> get props => [];
}

class PresentProductsInitial extends PresentProductsState {}

class PresentProductsError extends PresentProductsState {}

class PresentProductsLoading extends PresentProductsState {}

class PresentProductsLoaded extends PresentProductsState {
  final List<ProductPresent> products;

  PresentProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
