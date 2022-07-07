part of 'params_cubit.dart';

abstract class ParamsState extends Equatable {
  const ParamsState();

  @override
  List<Object> get props => [];
}

class ParamsInitial extends ParamsState {}

class ParamsSelected extends ParamsState {
  final Params params;

  const ParamsSelected({required this.params});

  @override
  List<Object> get props => [params];
}

class ParamsEmpty extends ParamsState {}
