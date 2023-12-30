import 'dart:convert';

import 'package:acim_helper/models/data.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

final history = <DataItem>[].obs;

class HistoryModel {
  void add(DataItem item) {
    if (history.isNotEmpty && item == history.first) {
      return;
    }

    history.remove(item);
    history.insert(0, item);

    // 保留 200 个
    if (history.length > 200) {
      history.removeRange(200, history.length);
    }

    GetStorage()
        .write('history', jsonEncode(history.map((e) => e.id).toList()));
  }

  static void load() {
    final jsonString = GetStorage().read('history');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    history.value = db.getListByIds(List.from(json));

    return;
  }
}
