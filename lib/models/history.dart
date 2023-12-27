import 'dart:convert';

import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

List<int> _history = [];

class HistoryModel extends ChangeNotifier {
  HistoryModel();

  List<DataItem> get history {
    return _history.map((e) => dataList[e]).toList();
  }

  Future<void> add(value) async {
    if (_history.isNotEmpty && value == _history.first) {
      return;
    }

    _history.remove(value);
    _history.insert(0, value);

    // 保留 200 个
    if (_history.length > 200) {
      _history.removeRange(200, _history.length);
    }

    final prefs = await getPrefs();
    await prefs.setString('history', jsonEncode(_history));

    notifyListeners();
  }

  static Future<void> load() async {
    final prefs = await getPrefs();
    final jsonString = prefs.getString('history');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    _history = List.from(json);
    return;
  }

  update() {
    notifyListeners();
  }
}
