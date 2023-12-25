import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/search.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulHookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchController controller = SearchController();
  String tab = 'fuzzy';

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
          SearchResult result =
              SearchResult(data: [], length: 0, page: 1, total: 0);
          if (tab == 'fuzzy') {
            result = fuzzySearch(
                keyword: controller.text, length: 200, page: 1, data: dataList);
          } else if (tab == 'exact') {
            result = exactSearch(
                keyword: controller.text, length: 200, page: 1, data: dataList);
          }
          print(result.data.length);
          return [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SegmentedButton(
                      segments: const [
                        ButtonSegment(value: 'fuzzy', label: Text('模糊搜索')),
                        ButtonSegment(value: 'exact', label: Text('精确搜索')),
                      ],
                      selected: {tab},
                      onSelectionChanged: (p0) => setState(() {
                        tab = p0.first;
                      }),
                    ),
                  ),
                  ...result.data.map((item) {
                    return Card(
                        color: theme.colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(item.text),
                        ));
                  }),
                ])),
          ].toList();
        },
      );
    });
  }
}
