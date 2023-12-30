import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

enum Language { zhHans, zhHant, enUS }

final config = {
  'themeMode': ThemeMode.system.index,
  'fontSize': 16,
  'language': Language.zhHans.index,
  'color': Colors.lightGreen.value
}.obs;

class Config {
  ThemeMode get themeMode {
    return ThemeMode.values[config['themeMode']!];
  }

  setThemeMode(ThemeMode value) {
    config['themeMode'] = value.index;
    save();
  }

  double get fontSize {
    return config['fontSize']!.toDouble();
  }

  setFontSize(double value) {
    config['fontSize'] = value.toInt();
    save();
  }

  Language get language {
    return Language.values[config['language']!];
  }

  setLanguage(Language value) {
    config['language'] = value.index;
    save();
  }

  Color get color {
    return Color(config['color']!);
  }

  setColor(Color value) {
    config['color'] = value.value;
    save();
  }

  save() {
    GetStorage().write('config', jsonEncode(config));
  }

  static void load() {
    final jsonString = GetStorage().read('config');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    config.value = {
      'themeMode': ThemeMode.values.length > json['themeMode']
          ? json['themeMode']
          : ThemeMode.system.index,
      'fontSize': json['fontSize'],
      'language': json['language'],
      'color': json['color']
    };
    return;
  }
}

// final config = Config();
