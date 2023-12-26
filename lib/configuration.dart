import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

enum Language { zhHans, zhHant, enUS }

var config = {
  'themeMode': ThemeMode.system.index,
  'fontSize': 16,
  'language': Language.zhHans.index,
  'color': Colors.lightGreen.value
};

class Config {
  Config();

  ThemeMode get themeMode {
    return ThemeMode.values[config['themeMode']!];
  }

  setThemeMode(ThemeMode value) async {
    config['themeMode'] = value.index;
    await save();
  }

  double get fontSize {
    return config['fontSize']!.toDouble();
  }

  setFontSize(double value) async {
    config['fontSize'] = value.toInt();
    await save();
  }

  Language get language {
    return Language.values[config['language']!];
  }

  setLanguage(Language value) async {
    config['language'] = value.index;
    await save();
  }

  Color get color {
    return Color(config['color']!);
  }

  setColor(Color value) async {
    config['color'] = value.value;
    await save();
  }

  static Future<void> load() async {
    final prefs = await getPrefs();
    final jsonString = prefs.getString('config');
    if (jsonString == null) {
      return;
    }
    var json = jsonDecode(jsonString);
    print('json themeMode: ${json['themeMode']}');
    print('ThemeMode.values: ${ThemeMode.values}');
    config = {
      'themeMode': ThemeMode.values.length > json['themeMode']
          ? json['themeMode']
          : ThemeMode.system.index,
      'fontSize': json['fontSize'],
      'language': json['language'],
      'color': json['color']
    };
    return;
  }

  Future<void> save() async {
    final prefs = await getPrefs();
    prefs.setString('config', jsonEncode(config));
  }
}
