part of 'present_products_bloc.dart';

abstract class PresentProductsEvent extends Equatable {
  const PresentProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadPresentProducts extends PresentProductsEvent {
  final Params params;

  const LoadPresentProducts({required this.params});

  @override
  List<Object> get props => [params];
}

class NextProductsPageEvent extends PresentProductsEvent {}
