import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class FavoriteBtn extends HookWidget {
  const FavoriteBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentText currentText = useContext().watch<CurrentText>();
    FavoriteModel favoriteModel = useContext().watch<FavoriteModel>();
    int index = currentText.current;
    bool isFavorite = favoriteModel.isFavorite(index);
    ThemeData theme = Theme.of(context);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : theme.iconTheme.color,
      ),
      onPressed: () {
        if (isFavorite) {
          favoriteModel.remove(index);
        } else {
          favoriteModel.add(index);
        }
      },
    );
  }
}
