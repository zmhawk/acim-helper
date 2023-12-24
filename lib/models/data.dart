import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataItem {
  final int index;
  final String text;
  DataItem(this.index, this.text);
}

class DataModel extends ChangeNotifier {
  late List<String> data;

  DataModel() {
    data = [];
    loadData().then((value) {
      data = jsonDecode(value).cast<String>();
      notifyListeners();
    });
  }

  bool get isEmpty => data.isEmpty;

  String getText(int index) {
    return data[index];
  }

  int getLength() {
    return data.length;
  }

  int randomIndex() {
    var random = Random();
    // 获取随机数
    return random.nextInt(data.length);
  }

  // 随机获取一条数据
  DataItem random() {
    // if (data.isEmpty) {
    //   return null;
    // }
    // 生成随机数
    var index = randomIndex();
    // 返回随机数据
    return DataItem(index, data[index]);
  }
}

Future<String> loadData() async {
  var string = await rootBundle.loadString('assets/zh_Hans.json');
  return string;
}
