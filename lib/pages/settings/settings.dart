import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulHookWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Config config = useContext().watch<Config>();
    DataModel dataModel = useContext().watch<DataModel>();

    void handleChangeLanguage(language) async {
      await config.setLanguage(language);
      await dataModel.loadData();
      setState(() {});
    }

    void handleChangeTheme(theme) async {
      await config.setThemeMode(theme);
      setState(() {});
    }

    void handleChangeFontSize(fontSize) async {
      await config.setFontSize(fontSize);
      setState(() {});
    }

    final fontSize = useState(config.fontSize);

    return Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: ListView(
          children: [
            const ListTile(
              title: Text('语言'),
            ),
            RadioListTile(
              value: Language.zhHans,
              groupValue: config.language,
              onChanged: handleChangeLanguage,
              title: const Text('简体中文'),
            ),
            RadioListTile(
              value: Language.zhHant,
              groupValue: config.language,
              onChanged: handleChangeLanguage,
              title: const Text('繁体中文'),
            ),
            const Divider(),
            const ListTile(
              title: Text('深色模式'),
            ),
            RadioListTile(
              value: ThemeMode.dark,
              groupValue: config.themeMode,
              onChanged: handleChangeTheme,
              title: const Text('开启'),
            ),
            RadioListTile(
              value: ThemeMode.light,
              groupValue: config.themeMode,
              onChanged: handleChangeTheme,
              title: const Text('关闭'),
            ),
            RadioListTile(
              value: ThemeMode.system,
              groupValue: config.themeMode,
              onChanged: handleChangeTheme,
              title: const Text('跟随系统'),
            ),
            const Divider(),
            const ListTile(
              title: Text('字号'),
            ),
            ListTile(
              title: Text(
                '奇迹课程 A Course In Miracles',
                style: TextStyle(fontSize: fontSize.value),
              ),
            ),
            Slider(
              value: fontSize.value,
              onChanged: (value) {
                fontSize.value = value;
              },
              onChangeEnd: (value) {
                handleChangeFontSize(value);
              },
              min: 12,
              max: 36,
              divisions: 12,
            ),
          ],
        ));
  }
}
