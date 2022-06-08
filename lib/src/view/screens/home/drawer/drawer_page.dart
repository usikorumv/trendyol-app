import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          title,
          style: TextStyle(),
        ),
      ),
      body: body,
    );
  }
}
