import 'package:bloc/bloc.dart';

class SimpleObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }
}
