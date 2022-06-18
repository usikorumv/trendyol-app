import 'package:flutter/material.dart';

class FavouriteListTileWidget extends StatelessWidget {
  const FavouriteListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: const Image(
        image: NetworkImage(''),
      ),
      title: const Text('Collection T-shirt - Black - Regular'),
      subtitle: Column(

      ),
    );
  }
}
