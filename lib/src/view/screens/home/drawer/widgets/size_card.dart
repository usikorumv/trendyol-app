import 'package:flutter/material.dart';

class SizeWidget extends StatefulWidget {
  const SizeWidget(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.id})
      : super(key: key);

  final Function(int) onPressed;
  final String title;
  final int id;

  @override
  State<SizeWidget> createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.onPressed(widget.id);

            isActive = !isActive;
          });
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: !isActive
                  ? const Color.fromRGBO(231, 231, 231, 1)
                  : const Color.fromRGBO(255, 141, 63, 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Center(
              child: Text(
            'XX',
            style: TextStyle(
                color: !isActive
                    ? const Color.fromRGBO(155, 155, 155, 1)
                    : const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          )),
        ),
      ),
    );
  }
}
