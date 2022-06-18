import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:trendyol_market/src/view/screens/home/drawer/widgets/brang_select.dart';
import 'package:trendyol_market/src/view/screens/home/drawer/widgets/color_circle.dart';

import '../../../constants/colors.dart';
import '../widgets/filter_button.dart';
import '../widgets/price_field.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/size_card.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final List _sizeDrawers = [
    CustomDrawer(
      title: "Размеры",
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 4, crossAxisSpacing: 4),
          itemCount: 1,
          itemBuilder: (context, index) {
            return SizeWidget(
              title: 'X',
              id: 1,
              onPressed: (i) {},
            );
          }),
    ),
    CustomDrawer(
      title: "Цвета",
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 4, crossAxisSpacing: 4),
          itemCount: 5,
          itemBuilder: (context, index) {
            return const ColorCircle();
          }),
    ),
    CustomDrawer(
      title: "Бренд",
      body: ListView.builder(
          itemBuilder: (context,index){
            return const BrandSelect();
          }
      )
    ),
  ];

  final _nameDrawer = <String>['Размер','Цвета','Бренд'];
  late Widget _currentDrawer;

  @override
  void initState() {
    super.initState();

    _currentDrawer = _sizeDrawers[0];
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
              padding: const EdgeInsets.symmetric(horizontal: 22.14, vertical: 15),
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
            Expanded(
              child: ListView.separated(
                itemCount: _sizeDrawers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 19.8),
                itemBuilder: (context, index) => FilterButton(
                  title: _nameDrawer[index],
                  drawer: _sizeDrawers[index],
                  onTap: (drawer) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _currentDrawer = drawer;
                      });

                      Scaffold.of(context).openEndDrawer();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
