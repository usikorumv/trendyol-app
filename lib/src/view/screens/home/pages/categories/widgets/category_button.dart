
import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/categories.dart';

import '../../../../../constants/colors.dart';


class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key, required this.category, required this.onTap}) : super(key: key);

  final Category category;
  final Function(Category) onTap;

  @override
  State<CategoryButton> createState() => CategoryButtonState();
}

class CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 62),
      child: GestureDetector(
        onTap: widget.onTap(widget.category),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.category.title,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Divider(),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
