import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    void handleChangeLanguage(language) async {
      Config().setLanguage(language);
      await Database.load();
      // 重新加载
      HistoryModel.load();
      FavoriteModel.load();
      drawItem.value = db.data[drawItem.value.index];
      viewItem.value = db.data[viewItem.value.index];
    }

    void handleChangeTheme(theme) {
      Config().setThemeMode(theme);
    }

    void handleChangeFontSize(fontSize) {
      Config().setFontSize(fontSize);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: ListView(
          children: [
            const ListTile(
              title: Text('语言'),
            ),
            Obx(() => RadioListTile(
                  value: Language.zhHans,
                  groupValue: Config().language,
                  onChanged: handleChangeLanguage,
                  title: const Text('简体中文'),
                )),
            Obx(() => RadioListTile(
                  value: Language.zhHant,
                  groupValue: Config().language,
                  onChanged: handleChangeLanguage,
                  title: const Text('繁体中文'),
                )),
            const Divider(),
            const ListTile(
              title: Text('深色模式'),
            ),
            Obx(() => RadioListTile(
                  value: ThemeMode.dark,
                  groupValue: Config().themeMode,
                  onChanged: handleChangeTheme,
                  title: const Text('开启'),
                )),
            Obx(() => RadioListTile(
                  value: ThemeMode.light,
                  groupValue: Config().themeMode,
                  onChanged: handleChangeTheme,
                  title: const Text('关闭'),
                )),
            Obx(() => RadioListTile(
                  value: ThemeMode.system,
                  groupValue: Config().themeMode,
                  onChanged: handleChangeTheme,
                  title: const Text('跟随系统'),
                )),
            const Divider(),
            const ListTile(
              title: Text('字号'),
            ),
            Obx(() => ListTile(
                  title: Text(
                    '奇迹课程 A Course In Miracles',
                    style: TextStyle(fontSize: Config().fontSize),
                  ),
                )),
            Obx(() => Slider(
                  value: Config().fontSize,
                  onChanged: (value) {
                    Config().setFontSize(value);
                  },
                  onChangeEnd: (value) {
                    handleChangeFontSize(value);
                  },
                  min: 12,
                  max: 36,
                  divisions: 12,
                )),
          ],
        ));
  }
}
