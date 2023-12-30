import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FavoriteBtn extends StatelessWidget {
  const FavoriteBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isFavorite = favorite.isFavorite(database.current);
    print('FavoriteBtn');
    // print(favorite.data);
    ThemeData theme = Theme.of(context);

    return Obx(() {
      final isFavorite = favorite.contains(viewItem.value);
      return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : theme.iconTheme.color,
        ),
        onPressed: () {
          if (isFavorite) {
            FavoriteModel().remove(viewItem.value);
          } else {
            FavoriteModel().add(viewItem.value);
          }
        },
      );
    });
  }
}
