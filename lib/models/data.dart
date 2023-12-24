import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class Item {
  final String key;
  final String value;
  Item(this.key, this.value);

  static Item fromJson(Map<String, dynamic> json) {
    return Item(json['key'], json['value']);
  }
}

class DataModel extends ChangeNotifier {
  late List<Item> data;

  DataModel() {
    data = [];
    loadData().then((value) {
      data = (jsonDecode(value) as List<dynamic>)
          .map((e) => Item.fromJson(e))
          .toList();
      notifyListeners();
    });
  }

  bool get isEmpty => data.isEmpty;

  // 随机获取一条数据
  Item random() {
    // if (data.isEmpty) {
    //   return null;
    // }
    // 生成随机数
    var random = Random();
    // 获取随机数
    var index = random.nextInt(data.length);
    // 返回随机数据
    return data[index];
  }
}

Future<String> loadData() async {
  var string = await rootBundle.loadString('assets/zh_Hans.json');
  return string;
}
