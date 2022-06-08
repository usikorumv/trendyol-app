part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  final int id;

  LoadProduct({required this.id});

  @override
  List<Object> get props => [id];
}
