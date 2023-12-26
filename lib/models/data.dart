import 'dart:convert';
import 'dart:math';
import 'package:acim_helper/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataItem {
  final int index;
  final String text;
  DataItem(this.index, this.text);
}

List<DataItem> dataList = [];

class DataModel extends ChangeNotifier {
  DataModel();

  bool get isEmpty => data.isEmpty;

  List<DataItem> get data => dataList;

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
    // 生成随机数
    var index = randomIndex();
    // 返回随机数据
    return data[index];
  }

  Future<List<DataItem>> loadData() async {
    List<DataItem> data = [];

    String fileName = {
      Language.zhHans: 'zh_Hans.json',
      Language.zhHant: 'zh_Hant.json',
      Language.enUS: 'en_US.json'
    }[Config().language]!;

    var string = await rootBundle.loadString('assets/$fileName');
    var textList = jsonDecode(string).cast<String>();
    for (var i = 0; i < textList.length; i++) {
      data.add(DataItem(i, textList[i]));
    }
    dataList = data;

    print('DataModel loadData');
    notifyListeners();
    return dataList;
  }
}
