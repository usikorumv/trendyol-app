import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

import '../../../../components/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.tabController,
    required this.id,
  }) : super(key: key);

  final CustomTabController tabController;
  final int id;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.offset + 20 >= controller.position.maxScrollExtent) {
        if (context.read<PresentProductsBloc>().state
            is PresentProductsLoaded) {
          context.read<PresentProductsBloc>().add(NextProductsPageEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: const [
              Expanded(child: SortButton()),
              SizedBox(width: 3),
              Expanded(child: FilterDrawerButton()),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                BlocBuilder<PresentProductsBloc, PresentProductsState>(
                    builder: (context, state) {
                  List products =
                      context.read<PresentProductsBloc>().presentProducts;

                  return Column(
                    children: [
                      for (int i = 0; i < products.length; i += 2)
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ProductCard(
                                    product: products[i],
                                  ),
                                ),
                                const SizedBox(width: 7),
                                if (i < products.length - 1)
                                  Expanded(
                                    child: ProductCard(
                                      product: products[i + 1],
                                    ),
                                  )
                                else
                                  const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                    ],
                  );
                }),
                BlocBuilder<PresentProductsBloc, PresentProductsState>(
                  builder: (context, state) {
                    if (state is PresentProductsLoading) {
                      return Column(
                        children: const [
                          SizedBox(height: 20),
                          CircularProgressIndicator(),
                        ],
                      );
                    }

                    if (state is PresentProductsEmpty) {
                      return Column(
                        children: const [
                          SizedBox(height: 20),
                          Text("No more products to load"),
                        ],
                      );
                    }

                    if (state is PresentProductsError) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 70,
                              color: kLightGreyColor[3],
                            ),
                          ),
                          Text(
                            "Something went Wrong!",
                            style: TextStyle(
                              color: kLightGreyColor[3],
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          )
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FilterDrawerButton extends StatelessWidget {
  const FilterDrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kLightGreyColor[0],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              color: kSecondaryColor,
            ),
            SizedBox(width: 3),
            Text(
              "Фильтр",
              style: TextStyle(
                color: kTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortButton extends StatefulWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  String dropDownValue = 'Сортировать';

  var items = [
    'Recommended',
    'Lowest price',
    'Highest Price',
    'Best - Sellers',
    'Favourite',
    'New Arrivals',
    'Most - Rated ',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kLightGreyColor[0],
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: kSecondaryColor,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                dropDownValue,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          icon: const SizedBox(),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (dropDownValue == newValue) {
                dropDownValue = 'Сортировать';
                return;
              }
              dropDownValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
