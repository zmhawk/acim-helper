import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';

class CurrentText extends ChangeNotifier {
  int current = DataModel().randomIndex();

  CurrentText();

  DataItem get getCurrent {
    if (current == -1) return DataItem(-1, '');
    return dataList[current];
  }

  void changeText(int item) {
    current = item;
    notifyListeners();
  }
}
