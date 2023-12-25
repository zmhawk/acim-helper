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
  late List<DataItem> data;

  DataModel() {
    data = [];
    loadData().then((value) {
      var textList = jsonDecode(value).cast<String>();
      for (var i = 0; i < textList.length; i++) {
        data.add(DataItem(i, textList[i]));
      }
      notifyListeners();
    });
  }

  bool get isEmpty => data.isEmpty;

  String getText(int index) {
    return data[index].text;
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
    return data[index];
  }
}

Future<String> loadData() async {
  var string = await rootBundle.loadString('assets/zh_Hans.json');
  return string;
}
