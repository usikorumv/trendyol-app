import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/category.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.category.name,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.keyboard_arrow_down,
              //       size: 30,
              //       color: kSecondaryColor,
              //     ))
            ],
          ),
          Divider(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
