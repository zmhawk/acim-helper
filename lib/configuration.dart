import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

enum Brightness { light, dark, system }

enum Language { zhHans, zhHant, enUS }

var config = {
  'brightness': Brightness.system.index,
  'fontSize': 16,
  'language': Language.zhHans.index,
  'color': Colors.lightGreen.value
};

class Config {
  Config();

  // fromJson(Map<String, int> json) {
  //   config = json;
  // }

  // Map<String, int> toJson() {
  //   return config;
  // }

  Brightness get brightness {
    return Brightness.values[config['brightness']!];
  }

  setBrightness(Brightness value) async {
    config['brightness'] = value.index;
    await save();
  }

  int get fontSize {
    return config['fontSize']!;
  }

  setFontSize(int value) async {
    config['fontSize'] = value;
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
    config = {
      'brightness': json['brightness'],
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
