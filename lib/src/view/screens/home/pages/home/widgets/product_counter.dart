import 'package:flutter/material.dart';

class ProductCounter extends StatefulWidget {
  const ProductCounter({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            splashRadius: 25,
            padding: const EdgeInsets.only(right: 6, bottom: 5),
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                if (counter <= 0) {
                  counter = 0;
                }
                counter--;
              });
            },
            icon: const Icon(
              Icons.remove,
              color: Colors.orange,
              size: 30,
            )),
        Container(
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Center(
              child: Text(
            '$counter',
            style: const TextStyle(fontSize: 19),
          )),
        ),
        IconButton(
            splashRadius: 25,
            padding: const EdgeInsets.only(left: 2, right: 20, bottom: 5),
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.orange,
              size: 30,
            )),
      ],
    );
  }
}
