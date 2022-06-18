import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'home/widgets/custom_serch_field.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[Container()],
          flexibleSpace: Container(
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(
                color: kLightGreyColor[0],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CustomSearchField()
          )
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){
            return Container();
          }
          ),
      
    );
  }
}