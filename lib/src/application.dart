import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trendyol_market/src/data/provider/trendyol_provider.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/logic/blocs/cart/cart_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/categories/categories_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/product/product_bloc.dart';
import 'package:trendyol_market/src/logic/cubits/brands/brands_cubit.dart';
import 'package:trendyol_market/src/logic/cubits/colors/colors_cubit.dart';
import 'package:trendyol_market/src/logic/cubits/sizes/sizes_cubit.dart';

import 'logic/blocs/auth/auth_bloc.dart';
import 'view/screens/home/home_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TrendyolService(
        trendyolApiClient: TrendyolApiClient(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              RepositoryProvider.of<TrendyolService>(context),
            ),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc(
              RepositoryProvider.of<TrendyolService>(context),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              RepositoryProvider.of<TrendyolService>(context),
            ),
          ),
          BlocProvider<BrandsCubit>(
            create: (context) => BrandsCubit(
              RepositoryProvider.of<TrendyolService>(context),
            )..loadBrands(),
          ),
          BlocProvider<ColorsCubit>(
            create: (context) => ColorsCubit(
              RepositoryProvider.of<TrendyolService>(context),
            )..loadColors(),
          ),
          BlocProvider<SizesCubit>(
            create: (context) => SizesCubit(
              RepositoryProvider.of<TrendyolService>(context),
            )..loadSizes(),
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
