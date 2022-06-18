import 'package:flutter/material.dart';

class BrandSelect extends StatefulWidget {
  const BrandSelect({Key? key}) : super(key: key);

  @override
  State<BrandSelect> createState() => _BrandSelectState();
}

class _BrandSelectState extends State<BrandSelect> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all(Colors.orange),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
      title: const Text(
        'Gucci',
        style: TextStyle(fontSize: 19),
      ),
    );
  }
}
