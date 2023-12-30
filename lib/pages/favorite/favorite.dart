import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('收藏夹'),
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: ListView.builder(
            itemCount: favorite.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                dense: true,
                title: Text(
                  favorite[index].text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  drawItem.value = favorite[index];
                  viewItem.value = favorite[index];
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Navigator.defaultRouteName,
                    (route) => false,
                  );
                },
              );
            }));
  }
}
