import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/logic/cubits/brands/brands_cubit.dart';
import 'package:trendyol_market/src/logic/cubits/colors/colors_cubit.dart';
import 'package:trendyol_market/src/logic/cubits/params/params_cubit.dart';
import 'package:trendyol_market/src/logic/cubits/sizes/sizes_cubit.dart';
import 'package:trendyol_market/src/models/brands/brand.dart';
import 'package:trendyol_market/src/models/colors/color.dart';
import 'package:trendyol_market/src/models/sizes/size.dart';
import 'package:trendyol_market/src/view/screens/home/drawer/widgets/brand_select.dart';
import 'package:trendyol_market/src/view/screens/home/drawer/widgets/color_circle.dart';

import '../../../constants/colors.dart';
import '../widgets/filter_button.dart';
import '../widgets/price_field.dart';
import 'widgets/custom_drawer.dart';
// ignore: unused_import
import 'widgets/size_card.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    Key? key,
    required this.paramsCubit,
    required this.presentProductsBloc,
  }) : super(key: key);

  final ParamsCubit paramsCubit;
  final PresentProductsBloc presentProductsBloc;

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late List<CustomDrawer> _sizeDrawers;
  late Widget _currentDrawer;

  @override
  void initState() {
    super.initState();

    _currentDrawer = const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        endDrawer: _currentDrawer,
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.14, vertical: 15),
              child: Row(
                children: [
                  Text(
                    "Фильтры",
                    style: TextStyle(
                        color: kLightGreyColor[3],
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: "Очистить",
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: CLEAR FILTRES
                        },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 21.51, 17.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Цена",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const PriceField(defaultPrice: 0),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 69),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      const PriceField(defaultPrice: 10000),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<BrandsCubit, BrandsState>(
              builder: (context, state) {
                if (state is BrandsLoading) {
                  return Column(
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  );
                }
                if (state is BrandsLoaded) {
                  List<Brand> brands = state.brands.toList();
                  return Column(
                    children: [
                      FilterButton(
                        title: "Бренды",
                        elements: brands.map((brand) => brand.title).toList(),
                        drawer: CustomDrawer(
                          title: "Бренды",
                          body: ListView.builder(
                            itemCount: brands.length,
                            itemBuilder: (context, index) {
                              return BrandSelect(
                                id: index,
                                brand: brands[index],
                                isWasSelected:
                                    widget.paramsCubit.params.brand ==
                                        brands[index].slug,
                                onTap: (id) {
                                  if (widget.paramsCubit.params.brand != "") {
                                    widget.paramsCubit.remove({"brand": ""});
                                  } else {
                                    widget.paramsCubit
                                        .add({"brand": brands[id].slug});
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        onTap: (drawer) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _currentDrawer = drawer;
                            });

                            Scaffold.of(context).openEndDrawer();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
                if (state is BrandsError) {
                  return Column(
                    children: const [
                      SizedBox(height: 20),
                      Text("Failed to load Brands"),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<ColorsCubit, ColorsState>(
              builder: (context, state) {
                if (state is ColorsLoading) {
                  return Column(
                    children: const [
                      SizedBox(height: 30),
                      CircularProgressIndicator(),
                    ],
                  );
                }
                if (state is ColorsLoaded) {
                  List<Color> colors = state.colors;
                  return Column(
                    children: [
                      FilterButton(
                        title: "Цвета",
                        elements: colors.map((color) => color.title).toList(),
                        drawer: CustomDrawer(
                          title: "Цвета",
                          body: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4),
                            itemCount: colors.length,
                            itemBuilder: (context, index) {
                              return ColorCircle(
                                id: index,
                                color: colors[index],
                                // TODO: Add colors
                                onTap: (id) {},
                              );
                            },
                          ),
                        ),
                        onTap: (drawer) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _currentDrawer = drawer;
                            });

                            Scaffold.of(context).openEndDrawer();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
                if (state is ColorsError) {
                  return Column(
                    children: const [
                      SizedBox(height: 40),
                      Text("Failed to load Colors"),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<SizesCubit, SizesState>(
              builder: (context, state) {
                if (state is SizesLoadind) {
                  return Column(
                    children: const [
                      SizedBox(height: 30),
                      CircularProgressIndicator(),
                    ],
                  );
                }
                if (state is SizesLoaded) {
                  List<Size> sizes = state.sizes;
                  return Column(
                    children: [
                      FilterButton(
                        title: "Размеры",
                        elements: sizes.map((size) => size.title).toList(),
                        drawer: CustomDrawer(
                          title: "Размеры",
                          body: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4),
                            itemCount: sizes.length,
                            itemBuilder: (context, index) {
                              return SizeWidget(
                                title: sizes[index].title,
                                id: index,
                                onPressed: (id) {},
                              );
                            },
                          ),
                        ),
                        onTap: (drawer) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _currentDrawer = drawer;
                            });

                            Scaffold.of(context).openEndDrawer();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
                if (state is ColorsError) {
                  return Column(
                    children: const [
                      SizedBox(height: 40),
                      Text("Failed to load Sizes"),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
