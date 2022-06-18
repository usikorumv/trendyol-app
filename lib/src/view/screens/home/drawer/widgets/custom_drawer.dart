import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trendyol_market/src/view/constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, this.title, this.body}) : super(key: key);

  final String? title;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        // titleSpacing: 0,
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 20,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: Text(
          title ?? "Title",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kLightGreyColor[3]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 19, right: 10),
            child: RichText(
              text: TextSpan(
                text: "Выбрать все",
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO: CLEAR FILTRES
                  },
              ),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
