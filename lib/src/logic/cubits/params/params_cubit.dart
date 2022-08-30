import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendyol_market/src/models/params.dart';

part 'params_state.dart';

class ParamsCubit extends Cubit<ParamsState> {
  ParamsCubit() : super(ParamsEmpty()) {
    params = const Params();
  }

  late Params params;

  void clear() {
    params = const Params();
  }

  void add(Map<String, String> map) {
    params = params.copyWithMap(map);

    // emit(ParamsSelected(params: params));
  }

  void remove(Map<String, String> map) {
    params = params.removeFromMap(map);

    // if (params.isEmpty) {
    //   emit(ParamsEmpty());
    // }
  }
}
