import 'package:acim_helper/pages/history/history.dart';
import 'package:acim_helper/pages/settings/settings.dart';
import 'package:flutter/material.dart';

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
      ],
    );
  }
}
