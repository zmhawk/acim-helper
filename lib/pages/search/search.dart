import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    return Consumer<DataModel>(builder: (context, data, child) {
      return SearchAnchor.bar(
        isFullScreen: true,
        barHintText: '搜索',
        barLeading: IconButton(
          onPressed: () {
            scaffold.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        barTrailing: const [
          ShareMenu(),
        ],
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<Widget>.generate(
            5,
            (int index) {
              return ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Initial list item $index'),
              );
            },
          );
        },
      );
    });
  }
}
