import 'dart:convert';

import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

final favorite = <DataItem>[].obs;

class FavoriteModel {
  void add(DataItem item) {
    if (favorite.isNotEmpty && item == favorite.first) {
      return;
    }

    favorite.remove(item);
    favorite.insert(0, item);
    save();
  }

  void remove(DataItem item) {
    favorite.remove(item);

    save();
  }

  void save() {
    GetStorage()
        .write('favorite', jsonEncode(favorite.map((e) => e.id).toList()));
  }

  static void load() {
    final jsonString = GetStorage().read('favorite');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    favorite.value = db.getListByIds(List.from(json));
    return;
  }
}
