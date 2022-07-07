import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/components/custom_tab_controller.dart';

import '../../../constants/colors.dart';
import '../widgets/favourite_list_tile_widget.dart';
import 'home/widgets/custom_serch_field.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key, required this.id, required this.tabController})
      : super(key: key);

  final CustomTabController tabController;
  final int id;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    // widget.tabController.onTap = (page) {
    //   if (page == widget.id) {}
    // };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              child: const CustomSearchField())),
      // body: ListView.separated(
      //   itemCount: 3,
      //   itemBuilder: (context, index) {
      //     return const FavouriteListTileWidget();
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return const Divider(
      //       height: 10,
      //       endIndent: 20,
      //       indent: 20,
      //       color: Colors.grey,
      //     );
      //   },
      // ),
    );
  }
}
