import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendyol_market/src/data/repository/repository.dart';
import 'package:trendyol_market/src/logic/blocs/present_products/present_products_bloc.dart';
import 'package:trendyol_market/src/logic/cubits/params/params_cubit.dart';
import 'package:trendyol_market/src/models/params.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';
import 'package:trendyol_market/src/view/screens/home/pages/home/widgets/custom_serch_field.dart';

import 'drawer/filter_drawer.dart';

import 'pages/cart_page.dart';
import 'pages/categories_page.dart';
import 'pages/favorite_page.dart';
import 'pages/home/home_page.dart';
import 'pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late CustomTabController tabController;
  late List<Widget> body;

  late List _appBar;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      tabController.onTap(_selectedIndex);
    });
  }

  ParamsCubit paramsCubit = ParamsCubit();
  Params lastParams = const Params();
  late PresentProductsBloc presentProductsBloc;

  @override
  void initState() {
    super.initState();

    tabController = CustomTabController();

    presentProductsBloc =
        PresentProductsBloc(RepositoryProvider.of<TrendyolService>(context));

    _appBar = [
      AppBar(
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
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 10),
            isScrollable: true,
            onTap: (i) {
              if (i == 0) {
                paramsCubit.add({"category": "None->erkek-giyim"});
              }
              if (i == 1) {
                paramsCubit.add({"category": "None->kadın-giyim"});
              }
              if (i == 2) {
                paramsCubit.add({"category": "None->cocuk-giyim"});
              }
              presentProductsBloc
                  .add(LoadPresentProducts(params: paramsCubit.params));
            },
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
      ),
      CategoriesPage.appBar,
      const PreferredSize(child: SizedBox(), preferredSize: Size.zero),
      CartPage.appBar,
      const PreferredSize(child: SizedBox(), preferredSize: Size.zero),
    ];

    body = [
      MultiBlocProvider(
        providers: [
          BlocProvider<ParamsCubit>(
            create: (context) =>
                paramsCubit..add({"category": "None->erkek-giyim"}),
          ),
          BlocProvider<PresentProductsBloc>(
            create: (context) => presentProductsBloc
              ..add(
                LoadPresentProducts(
                  params: context.read<ParamsCubit>().params,
                ),
              ),
          ),
        ],
        child: HomePage(id: 0, tabController: tabController),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider<PresentProductsBloc>(
            create: (context) => PresentProductsBloc(
                RepositoryProvider.of<TrendyolService>(context)),
          ),
        ],
        child: CategoriesPage(id: 1, tabController: tabController),
      ),
      FavoritesPage(id: 2, tabController: tabController),
      CartPage(id: 3, tabController: tabController),
      ProfilePage(tabController: tabController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: _appBar[_selectedIndex],
          endDrawerEnableOpenDragGesture: false,
          endDrawer: FilterDrawer(
            paramsCubit: paramsCubit,
            presentProductsBloc: presentProductsBloc,
          ),
          onEndDrawerChanged: (isOpened) {
            if (!isOpened) {
              if (paramsCubit.params != lastParams) {
                lastParams = paramsCubit.params;

                presentProductsBloc
                    .add(LoadPresentProducts(params: paramsCubit.params));
              }
            }
          },
          body: IndexedStack(
            children: body,
            index: _selectedIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _bottomNavBarIcon(Icons.home_rounded),
              _bottomNavBarIcon(Icons.apps_rounded),
              _bottomNavBarIcon(Icons.favorite_rounded),
              _bottomNavBarIcon(Icons.shopping_cart),
              _bottomNavBarIcon(Icons.person_rounded),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0XFF6A687A),
            unselectedItemColor: const Color(0xFFAAC3C8),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarIcon(IconData icon) =>
      BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 22,
        ),
        label: "",
        activeIcon: Icon(
          icon,
          size: 30,
        ),
      );
}
