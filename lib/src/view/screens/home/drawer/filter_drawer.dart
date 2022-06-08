import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  final List _drawers = [
    CustomDrawer(
      title: "Размеры",
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 4, crossAxisSpacing: 4),
          itemCount: 10,
          itemBuilder: (context, index) {
            return SizeWidget(
              title: 'X',
              id: 1,
              onPressed: (i) {},
            );
          }),
    )
  ];

  late Widget _currentDrawer;

  @override
  void initState() {
    super.initState();

    _currentDrawer = _drawers[0];
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
              padding: EdgeInsets.symmetric(horizontal: 22.14, vertical: 15),
              child: Row(
                children: [
                  Text(
                    "Фильтры",
                    style: TextStyle(
                        color: kLightGreyColor[3],
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      text: "Очистить",
                      style: TextStyle(
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
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 21.51, 17.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Цена",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      PriceField(defaultPrice: 0),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 69),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      PriceField(defaultPrice: 10000),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) => SizedBox(height: 19.8),
                itemBuilder: (context, index) => FilterButton(
                  drawer: _drawers[index],
                  onTap: (drawer) {
                    setState(() {
                      _currentDrawer = drawer;
                    });

                    Scaffold.of(context).openEndDrawer();
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
