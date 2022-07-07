part of 'present_products_bloc.dart';

abstract class PresentProductsEvent extends Equatable {
  const PresentProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadPresentProducts extends PresentProductsEvent {}
