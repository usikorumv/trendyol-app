import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trendyol_market/src/data/utils/observer.dart';

import 'src/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then(
      (value) => BlocOverrides.runZoned(
        () => runApp(const Application()),
        blocObserver: SimpleObserver(),
      ),
    ),
    storage: storage,
  );
}
