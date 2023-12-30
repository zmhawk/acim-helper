import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class TextView extends StatelessWidget {
  const TextView({Key? key, required this.data}) : super(key: key);

  // 此处为抽卡得到的数据，不是当前展示的数据
  final DataItem data;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: data.index);

    print('TextView');

    // ever(viewItem, (callback) => HistoryModel().add(viewItem.value));

    return Expanded(
      child: GestureDetector(
        onTapUp: (details) {
          // FIX: 文本超长，出现滚动条时，无法翻页
          var width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 3) {
            controller.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOutCubicEmphasized);
          } else if (details.globalPosition.dx > width / 3 * 2) {
            controller.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease);
          }
        },
        child: PageView.custom(
          controller: controller,
          scrollDirection: Axis.horizontal,
          // 翻页时
          onPageChanged: (index) {
            viewItem.value = db.data[index];
          },
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: db.length,
            (context, i) {
              return SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 75),
                    child: SelectionArea(
                        child: Obx(
                      () => Text(
                        db.data[i].text,
                        style:
                            TextStyle(fontSize: Config().fontSize, height: 1.8),
                      ),
                    )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
