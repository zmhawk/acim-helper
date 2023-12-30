import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:acim_helper/pages/favorite/favorite_btn.dart';
import 'package:acim_helper/pages/menu/menu.dart';
import 'package:acim_helper/pages/search/search.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:acim_helper/pages/text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ever(viewItem, (callback) => HistoryModel().add(viewItem.value));
    // ever(drawItem, (callback) => viewItem.value = drawItem.value);
    // ever(dataList, (callback) => drawItem.value = Database().random());

    // 如果是第一次打开，随机抽取一条数据
    if (viewItem.value.index == -1) {
      drawItem.value = Database().random();
      viewItem.value = drawItem.value;
      // HistoryModel().add(drawItem.value);
    }
    print('home');

    return Scaffold(
      appBar: AppBar(
          title: const Text('ACIM 小帮手'),
          actions: const [SearchPage(), FavoriteBtn(), ShareMenu()]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() => TextView(
                    data: drawItem.value,
                    key: Key(drawItem.value.id),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          drawItem.value = db.random();
          viewItem.value = drawItem.value;
          // HistoryModel().add(drawItem.value);
        },
        child: const Icon(Icons.refresh_outlined),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
