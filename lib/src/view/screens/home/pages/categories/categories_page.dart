import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/category.dart';
import 'package:trendyol_market/src/view/screens/home/pages/categories/widgets/category_button.dart';
import 'package:trendyol_market/src/view/screens/home/pages/categories/widgets/category_dropdown.dart';

import 'package:flutter_tree/flutter_tree.dart';
import 'package:trendyol_market/src/view/screens/home/pages/home/widgets/custom_serch_field.dart';

import '../../../../constants/colors.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

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
  final serverData = [
    {
      "checked": true,
      "children": [
        {
          "checked": true,
          "show": false,
          "children": [],
          "id": 11,
          "pid": 1,
          "show": false,
          "text": "Child title 11",
        },
      ],
      "id": 1,
      "pid": 0,
      "show": false,
      "text": "Erkek Giyim",
    },
  ];

  @override
  Widget build(BuildContext context) {
    /// Map server data to tree node data
    TreeNodeData mapServerDataToTreeData(Map data) {
      return TreeNodeData(
        extra: data,
        title: data['text'],
        expaned: data['show'],
        checked: data['checked'],
        children:
            List.from(data['children'].map((x) => mapServerDataToTreeData(x))),
      );
    }

    /// Generate tree data
    List<TreeNodeData> treeData = List.generate(
      serverData.length,
      (index) => mapServerDataToTreeData(serverData[index]),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          // TreeView(
          //   data: treeData,
          //   onTap: (node) {
          //     print(node.extra);
          //   },
          // ),
          CategoryDropdown(
            category: Category(
              name: "Erkek Giyim",
              slug: "erkek-giyim",
            ),
          ),
          // CategoryButton(
          //     category: Category(name: "Kofe", slug: "kofe"),
          //     onTap: (category) {}),
          // CategoryButton(
          //     category: Category(name: "T-Shirt", slug: "t-shirt"),
          //     onTap: (category) {})
        ],
      ),
    );
  }
}
