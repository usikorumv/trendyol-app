import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/data/provider/products_provider.dart';
import 'package:trendyol_market/src/data/repository/products_repository.dart';

import 'view/screens/home/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ProductsService(
            productsApiClient: ProductsApiClient(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // textTheme: GoogleFonts.interTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            ),
        home: HomeScreen(),
      ),
    );
  }
}
