import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> history = [];
  // List<Item> pages = [];
  // pages[0] 在 history 中的 index
  int offsetIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Consumer(builder: (context, DataModel data, child) {
      if (data.isEmpty) {
        return const Scaffold(
          body: Center(
            child: Text('Loading...'),
          ),
        );
      }
      if (history.isEmpty && !data.isEmpty) {
        history = [data.random(), data.random(), data.random()];
        // pages = [...history];
      }

      for (var element in history) {
        print(element.value);
      }

      return Scaffold(
        body: PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          onPageChanged: (value) {
            print(value);

            // 回到上一页
            if (value == 0) {
              // 如果已经是第一页，什么都不做
              if (offsetIndex == 0) {
                return;
              }
              // 当前不是第一页
              if (offsetIndex > 0) {
                setState(() {
                  offsetIndex = offsetIndex - 1;
                  // pages = history.sublist(offsetIndex, offsetIndex + 3);
                });
                controller.jumpToPage(1);
              }
            }

            // 中间页
            if (value == 1) {
              return;
            }

            // 下一页
            if (value == 2) {
              if (offsetIndex + 3 == history.length) {
                var item = data.random();
                setState(() {
                  history = [...history, item];
                  offsetIndex += 1;
                });
              } else {
                setState(() {
                  offsetIndex += 1;
                });
              }
              controller.jumpToPage(1);
            }
          },
          children: history
              .sublist(offsetIndex, offsetIndex + 3)
              .map(
                (e) => Center(
                  child: SelectionArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            e.value,
                            style: const TextStyle(fontSize: 20, height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
