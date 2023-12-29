import 'dart:io';

import 'package:acim_helper/pages/favorite/favorite.dart';
import 'package:acim_helper/pages/history/history.dart';
import 'package:acim_helper/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

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
          leading: const Icon(Icons.history_outlined),
          title: const Text('浏览记录'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border_outlined),
          title: const Text('收藏夹'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FavoritePage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('设置'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('关于此应用'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'ACIM 小帮手',
              applicationIcon: const Icon(Icons.book_outlined),
              children: [
                const Text('原微信小程序：ACIM 小帮手'),
                const Text('作者：逆行者'),
                const Text('微信公众号：逆行者的奇迹漫谈'),
                const Linkify(
                    text: '项目地址：https://github.com/zmhawk/acim-helper'),
              ],
            );
          },
        ),
      ],
    );
  }
}
