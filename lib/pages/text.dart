import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class TextView extends HookWidget {
  const TextView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Config config = useContext().watch<Config>();
    DataModel dataModel = useContext().watch<DataModel>();
    final PageController controller = PageController(initialPage: index);

    return Expanded(
      child: GestureDetector(
        onTapUp: (details) {
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
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: dataModel.getLength(),
            (context, i) {
              return SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 75),
                    child: SelectionArea(
                      child: Text(
                        dataModel.data[i].text,
                        style:
                            TextStyle(fontSize: config.fontSize, height: 1.8),
                      ),
                    ),
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
