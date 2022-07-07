import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trendyol_market/src/data/provider/trendyol_provider.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/logic/blocs/cart/cart_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/categories/categories_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/product/product_bloc.dart';
import 'package:trendyol_market/src/logic/cubits/params/params_cubit.dart';

import 'logic/blocs/auth/auth_bloc.dart';
import 'view/screens/home/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Service(
            trendyolApiClient: TrendyolApiClient(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<PresentProductsBloc>(
            create: (context) => PresentProductsBloc(
              RepositoryProvider.of<Service>(context),
            ),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              RepositoryProvider.of<Service>(context),
            ),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc(
              RepositoryProvider.of<Service>(context),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              RepositoryProvider.of<Service>(context),
            ),
          ),
          BlocProvider<ParamsCubit>(
            create: (context) => ParamsCubit(),
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
              home: const HomeScreen(),
            );
          }),
        ),
      ),
    );
  }
}
