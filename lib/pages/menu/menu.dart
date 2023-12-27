import 'package:acim_helper/pages/history/history.dart';
import 'package:acim_helper/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return NavigationDrawer(
      children: [
        DrawerHeader(
          decoration:
              BoxDecoration(color: themeData.colorScheme.primaryContainer),
          child: Text(
            'A Course in Miracles',
            style: TextStyle(
              fontSize: 24,
              color: themeData.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        ListTile(
          title: const Text('浏览记录'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryPage()));
            // print('index: $index');
            // if (index > -1) {
            //   Navigator.pop(context, index);
            // }
          },
        ),
        ListTile(
          title: const Text('设置'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingPage()));
          },
        ),
        ListTile(
          title: const Text('联系作者'),
          onTap: () async {
            Clipboard.setData(const ClipboardData(text: '逆行者的奇迹漫谈'));
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('联系作者'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('微信公众号：逆行者的奇迹漫谈'),
                        Text(
                          '（已复制到剪贴板）',
                          style: themeData.textTheme.bodySmall,
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }
}
