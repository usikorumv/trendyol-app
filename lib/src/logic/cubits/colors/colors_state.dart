part of 'colors_cubit.dart';

abstract class ColorsState extends Equatable {
  const ColorsState();

  @override
  List<Object> get props => [];
}

class ColorsInitial extends ColorsState {}

class ColorsError extends ColorsState {}

class ColorsLoading extends ColorsState {}

class ColorsLoaded extends ColorsState {
  final List<Color> colors;

  const ColorsLoaded({required this.colors});

  @override
  List<Object> get props => [colors];
}
