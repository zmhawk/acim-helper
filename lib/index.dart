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
      if (history.isEmpty) {
        history = [data.random(), data.random(), data.random()];
      }
      // assert(history.isNotEmpty);

      return Scaffold(
        body: PageView.custom(
          controller: controller,
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.hardEdge,
          onPageChanged: (value) {
            if (value == history.length - 1) {
              setState(() {
                history.add(data.random());
              });
            }
          },
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var item = history[index];
              var scrollController = ScrollController();
              // ScrollPhysics physics = const ScrollPhysics();
              return NotificationListener(
                // onVerticalDragUpdate: (details) {
                //   print(scrollController.offset);
                // },
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    // print(notification.);
                    if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent) {
                      print('到底了');
                      controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      // setState(() {
                      //   physics = const NeverScrollableScrollPhysics();
                      // });
                    }
                    return false;
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  key: ValueKey<Item>(item),
                  controller: scrollController,
                  // physics: physics,
                  child: SelectionArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            item.value,
                            style: const TextStyle(fontSize: 30, height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: history.length,
            findChildIndexCallback: (Key key) {
              final ValueKey<Item> valueKey = key as ValueKey<Item>;
              final Item data = valueKey.value;
              return history.indexOf(data);
            },
          ),
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
