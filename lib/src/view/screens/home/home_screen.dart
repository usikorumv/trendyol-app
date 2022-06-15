import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

import 'drawer/filter_drawer.dart';

import 'pages/cart_page.dart';
import 'pages/categories/categories_page.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _body = const [
    HomePage(),
    CategoriesPage(),
    FavoritesPage(),
    CartPage(),
    ProfilePage(),
  ];

  final List _appBar = [
    HomePage.appBar,
    CategoriesPage.appBar,
    PreferredSize(child: SizedBox(), preferredSize: Size.zero),
    PreferredSize(child: SizedBox(), preferredSize: Size.zero),
    PreferredSize(child: SizedBox(), preferredSize: Size.zero),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: _appBar[_selectedIndex],
          endDrawerEnableOpenDragGesture: false,
          endDrawer: FilterDrawer(),
          body: IndexedStack(
            children: _body,
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
