part of 'sizes_cubit.dart';

abstract class SizesState extends Equatable {
  const SizesState();

  @override
  List<Object> get props => [];
}

class SizesInitial extends SizesState {}

class SizesError extends SizesState {}

class SizesLoadind extends SizesState {}

class SizesLoaded extends SizesState {
  final List<Size> sizes;

  const SizesLoaded({required this.sizes});

  @override
  List<Object> get props => [sizes];
}
