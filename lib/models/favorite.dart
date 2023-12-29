import 'dart:convert';

import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

List<int> _favorite = [];

class FavoriteModel extends ChangeNotifier {
  FavoriteModel();

  List<DataItem> get favorite {
    return _favorite.map((e) => dataList[e]).toList();
  }

  bool isFavorite(int index) {
    return _favorite.contains(index);
  }

  Future<void> add(value) async {
    if (_favorite.isNotEmpty && value == _favorite.first) {
      return;
    }

    _favorite.remove(value);
    _favorite.insert(0, value);

    final prefs = await getPrefs();
    await prefs.setString('favorite', jsonEncode(_favorite));

    notifyListeners();
  }

  // remove
  Future<void> remove(value) async {
    _favorite.remove(value);

    final prefs = await getPrefs();
    await prefs.setString('favorite', jsonEncode(_favorite));

    notifyListeners();
  }

  static Future<void> load() async {
    final prefs = await getPrefs();
    final jsonString = prefs.getString('favorite');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    _favorite = List.from(json);
    return;
  }

  update() {
    notifyListeners();
  }
}
