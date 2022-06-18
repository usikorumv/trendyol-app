import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key,
      required this.drawer,
      required this.onTap,
      this.title,
      this.elements})
      : super(key: key);

  final Widget drawer;
  final String? title;
  final Function(Widget) onTap;
  final List<String>? elements;

  @override
  Widget build(BuildContext context) {
    String _title = title ?? "Title";
    List<String> _elements = ["Element 1", "Element 2"];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 21, right: 18),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: const TextStyle(
                      color: kTextColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 1.8),
                  Text(
                    _elements.join(", "),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kDarkGreyColor[0],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onTap(drawer);
                },
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kTextColor,
                  size: 18,
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
