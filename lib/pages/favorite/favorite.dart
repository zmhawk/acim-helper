import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class FavoritePage extends HookWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteModel favoriteModel = useContext().watch<FavoriteModel>();
    List<DataItem> favorite = favoriteModel.favorite;
    CurrentText currentText = useContext().watch<CurrentText>();

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
                  currentText.changeText(favorite[index].index);
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
