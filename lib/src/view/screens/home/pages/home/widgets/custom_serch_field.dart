import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({Key? key, this.onTap, this.hintText})
      : super(key: key);

  final Function? onTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 1.1),
              blurRadius: 2.0,
              spreadRadius: 0.0)
        ],
      ),
      child: TextFormField(
        onTap: () {
          onTap!();
        },
        decoration: InputDecoration(
          hintText: hintText ?? "Text",
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
