import 'dart:convert';
import 'dart:math';
import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/state_manager.dart';

class DataItem {
  final String id;
  final int index;
  final String text;

  DataItem(this.index, this.text, this.id);

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      json['index'] as int,
      json['text'] as String,
      json['id'] as String,
    );
  }
}

final dataList = <DataItem>[].obs;

final _hashMap = <String, DataItem>{}.obs;

// 抽卡得到的 item
final class Database {
  Database();

  List<DataItem> get data => dataList;

  int get length => data.length;

  bool get isEmpty => data.isEmpty;

  // 获取一组 id 对应的数据
  List<DataItem> getListByIds(List<String> ids) {
    final list = <DataItem>[];
    for (var id in ids) {
      list.add(getItemById(id)!);
    }
    return list;
  }

  // 获取指定 id 的数据
  DataItem? getItemById(String id) => _hashMap[id];

  // 随机获取一条数据
  DataItem random() {
    // 生成随机数
    var random = Random();
    // 获取随机数
    random.nextInt(dataList.length);
    var index = random.nextInt(dataList.length);
    print('random: $index');
    // 返回随机数据
    return dataList[index];
  }

  // 加载数据
  static Future<void> load() async {
    String fileName = {
      Language.zhHans: 'zh_Hans.json',
      Language.zhHant: 'zh_Hant.json',
      Language.enUS: 'en_US.json'
    }[Config().language]!;

    var string = await rootBundle.loadString('assets/$fileName');

    dataList.value = (jsonDecode(string) as List)
        .map((item) => DataItem.fromJson(item))
        .toList();

    _hashMap.value = {for (var item in dataList) item.id: item};

    print('reload');

    // // 如果是第一次打开，随机抽取一条数据
    // if (drawItem.value.index == -1) {
    //   drawItem.value = Database().random();
    //   viewItem.value = drawItem.value;
    // }
  }
}

final Database db = Database();
