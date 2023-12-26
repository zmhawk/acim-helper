import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

enum Brightness { light, dark, system }

enum Language { zhHans, zhHant, enUS }

class Config {
  Brightness? brightness = Brightness.system;
  int? fontSize = 16;
  Language? language = Language.zhHans;
  Color? color = Colors.lightGreen;

  Config({this.brightness, this.fontSize, this.language, this.color});

  Config.fromJson(Map<String, dynamic> json) {
    brightness = Brightness.values[json['brightness']];
    fontSize = json['fontSize'];
    language = Language.values[json['language']];
    color = Color(json['color']);
  }

  Map<String, dynamic> toJson() {
    return {
      'brightness': brightness?.index,
      'fontSize': fontSize,
      'language': language?.index,
      'color': color
    };
  }

  static Future<Config> load() async {
    final prefs = await getPrefs();
    final json = prefs.getString('config');
    if (json == null) {
      return Config();
    }
    return Config.fromJson(jsonDecode(json));
  }

  Future<void> save() async {
    final prefs = await getPrefs();
    prefs.setString('config', jsonEncode(toJson()));
  }

  static Future<void> reset() async {
    final prefs = await getPrefs();
    prefs.remove('config');
  }
}
