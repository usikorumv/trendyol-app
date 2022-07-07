import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

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

  final List _appBar = [
    HomePage.appBar,
    CategoriesPage.appBar,
    const PreferredSize(child: SizedBox(), preferredSize: Size.zero),
    CartPage.appBar,
    const PreferredSize(child: SizedBox(), preferredSize: Size.zero),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      tabController.onTap(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = CustomTabController();

    body = [
      HomePage(id: 0, tabController: tabController),
      CategoriesPage(id: 1, tabController: tabController),
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
          endDrawer: const FilterDrawer(),
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
