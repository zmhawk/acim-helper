import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';

class CurrentText extends ChangeNotifier {
  DataItem current = DataItem(-1, 'Loading...');

  DataItem get getCurrent => current;

  void changeText(DataItem item) {
    current = item;
    notifyListeners();
  }
}
