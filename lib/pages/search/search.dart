import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/search.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchController controller = SearchController();
  // SearchResult searchResult =
  //     SearchResult(data: [], length: 0, page: 1, total: 0);

  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    ThemeData theme = Theme.of(context);
    List<DataItem> dataList = context.watch<DataModel>().data;

    return Consumer<DataModel>(builder: (context, data, child) {
      return SearchAnchor.bar(
        searchController: controller,
        isFullScreen: true,
        viewBackgroundColor: theme.colorScheme.surface,
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
          print('keyword: ${controller.text}');
          SearchResult result = fuzzySearch(
              keyword: controller.text, length: 20, page: 1, data: dataList);
          print(result.data.length);
          return [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(label: Text('模糊搜索'), selected: true),
                ChoiceChip(
                  label: Text('精确搜索'),
                  selected: false,
                )
              ],
            ),
            const Divider(),
            ...result.data.map((item) {
              return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Card(
                      color: theme.colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(item.text),
                      )));
            }),
          ].toList();
        },
      );
    });
  }
}
