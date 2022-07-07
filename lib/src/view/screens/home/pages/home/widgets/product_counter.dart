import 'package:flutter/material.dart';

class ProductCounter extends StatefulWidget {
  const ProductCounter({
    Key? key,
    required this.onIncrease,
    required this.onDecrease, this.amount,
  }) : super(key: key);

  final int? amount;
  final Function onIncrease, onDecrease;

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  late int counter;

  @override
  void initState() {
    super.initState();

    counter = widget.amount ?? 1;
  }

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
                counter--;
                widget.onDecrease();
                if (counter < 1) {
                  counter = 1;
                }
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
                widget.onIncrease();
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
