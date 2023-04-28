import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/categories/categories_bloc.dart';
import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/models/categories/category.dart';
import 'package:trendyol_market/src/models/params.dart';

import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';

import '../../../components/dynamic_treeview.dart';
import '../../../constants/colors.dart';
import '../../../components/product_card.dart';
import 'home/home_page.dart';
import 'home/widgets/custom_serch_field.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage(
      {Key? key, required this.id, required this.tabController})
      : super(key: key);

  final CustomTabController tabController;
  final int id;

  static PreferredSizeWidget appBar = AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: <Widget>[Container()],
    flexibleSpace: Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: kLightGreyColor[0],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const CustomSearchField(),
    ),
  );

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool showCategories = true, inPage = false;

  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>().add(LoadCategories());

    widget.tabController.listeners.add(
      (page) {
        if (inPage && !showCategories) {
          showCategories = true;
          setState(() {});
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
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoriesLoaded) {
          return content(state.categories);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget content(List<Category> categories) {
    List<DataModel> data = [];

    for (var category in categories) {
      data.add(
        DataModel(
          id: category.slug,
          parentId: category.parent,
          name: category.title,
          extras: {"filter": category.filter},
        ),
      );
    }

    return showCategories
        ? SingleChildScrollView(
            child: DynamicTreeView(
              data: getData(data),
              config: const Config(
                rootId: "root",
                parentTextStyle: TextStyle(
                    fontSize: 16,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
                parentPaddingEdgeInsets:
                    EdgeInsets.only(left: 16, top: 0, bottom: 0),
                childrenTextStyle: TextStyle(
                    fontSize: 16,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
                arrowIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 32,
                  color: kSecondaryColor,
                ),
              ),
              onTap: (category) {
                setState(() {
                  showCategories = false;

                  context.read<PresentProductsBloc>().add(
                        LoadPresentProducts(params: Params()),
                      );
                });
              },
              width: MediaQuery.of(context).size.width,
            ),
          )
        : Column(
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
                    List products =
                        context.read<PresentProductsBloc>().presentProducts;

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
        );
  }
}

List<BaseData> getData(List<BaseData> data) {
  List<BaseData> corrected = [
    DataModel(
      id: "root",
      name: 'Root',
      parentId: "",
      extras: {'key': ''},
    ),
    ...data,
  ];

  return corrected;
}

class DataModel implements BaseData {
  final String id;
  final String parentId;
  final String name;

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> extras;

  DataModel(
      {required this.id,
      required this.parentId,
      required this.name,
      required this.extras});

  @override
  String toString() {
    return "id: $id, parentId: $parentId, name: $name, extrass: $extras";
  }

  @override
  String getId() {
    return id;
  }

  @override
  Map<String, dynamic> getExtraData() {
    return extras;
  }

  @override
  String getParentId() {
    return parentId;
  }

  @override
  String getTitle() {
    return name;
  }
}
