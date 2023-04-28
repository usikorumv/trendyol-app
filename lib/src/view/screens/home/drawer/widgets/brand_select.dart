import 'package:flutter/material.dart';
import 'package:trendyol_market/src/models/brands/brand.dart';

class BrandSelect extends StatefulWidget {
  const BrandSelect(
      {Key? key,
      required this.brand,
      required this.onTap,
      required this.id,
      required this.isWasSelected})
      : super(key: key);

  final int id;
  final bool isWasSelected;
  final Brand brand;
  final Function(int) onTap;

  @override
  State<BrandSelect> createState() => _BrandSelectState();
}

class _BrandSelectState extends State<BrandSelect> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.isWasSelected;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all(Colors.orange),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            widget.onTap(widget.id);

            isChecked = value!;
          });
        },
      ),
      title: Text(
        widget.brand.title,
        style: const TextStyle(fontSize: 19),
      ),
    );
  }
}
