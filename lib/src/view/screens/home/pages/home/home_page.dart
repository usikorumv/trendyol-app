import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/models/products/product/product.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/screens/home/pages/home/widgets/custom_serch_field.dart';

import '../../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.id, required this.tabController})
      : super(key: key);

  final CustomTabController tabController;
  final int id;

  static PreferredSizeWidget appBar = AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: const [SizedBox()],
    flexibleSpace: Container(
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
        decoration: BoxDecoration(
          color: kLightGreyColor[0],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CustomSearchField()),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 1,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 10),
        isScrollable: true,
        onTap: (index) {},
        indicatorColor: Colors.black,
        tabs: const [
          Text(
            'Мужчинам',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            'Женщинам',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            'Детям',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    ),
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inPage = false;

  @override
  void initState() {
    super.initState();

    inPage = true;

    context.read<PresentProductsBloc>().add(LoadPresentProducts());

    widget.tabController.listeners.add(
      (page) {
        if (page == widget.id && inPage) {
          context.read<PresentProductsBloc>().add(LoadPresentProducts());
          return;
        }

        if (page == widget.id) {
          inPage = true;
        } else {
          inPage = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        setState(() {
          context.read<PresentProductsBloc>().add(LoadPresentProducts());
        });
      },
      child: Column(
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
            child: BlocBuilder<PresentProductsBloc, PresentProductsState>(
              builder: (context, state) {
                if (state is PresentProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PresentProductsLoaded) {
                  List<ProductPresent> products = state.products;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
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
                                  if (i < products.length - 2)
                                    Expanded(
                                      child: ProductCard(
                                        product: products[i + 1],
                                      ),
                                    )
                                  else
                                    const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                      ],
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              },
            ),
          ),
        ],
      ),
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
