part of 'brands_cubit.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();

  @override
  List<Object> get props => [];
}

class BrandsInitial extends BrandsState {}

class BrandsError extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<Brand> brands;

  const BrandsLoaded({required this.brands});

  @override
  List<Object> get props => [brands];
}
