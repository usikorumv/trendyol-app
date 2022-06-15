import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trendyol_market/src/data/provider/products_provider.dart';
import 'package:trendyol_market/src/data/repository/products_repository.dart';
import 'package:trendyol_market/src/logic/auth/auth_bloc.dart';
import 'package:trendyol_market/src/view/screens/login/login_screen.dart';
import 'package:trendyol_market/src/view/screens/product/product_screen.dart';

import 'view/screens/home/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ProductsService(
              productsApiClient: ProductsApiClient(),
            ),
          ),
        ],
        child: Sizer(
          builder: ((context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  // textTheme: GoogleFonts.interTextTheme(
                  //   Theme.of(context).textTheme,
                  // ),
                  ),
              home: HomeScreen(),
            );
          }),
        ),
      ),
    );
  }
}
