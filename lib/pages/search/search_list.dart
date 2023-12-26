import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/search/search_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SearchResultList extends HookWidget {
  const SearchResultList({Key? key, required this.keyword, required this.tab})
      : super(key: key);

  final String keyword;
  final String tab;

  @override
  Widget build(BuildContext context) {
    List<DataItem> dataList = context.watch<DataModel>().data;

    CurrentText currentText = useContext().watch<CurrentText>();

    print('search result list build: $keyword, $tab');

    SearchResult result = SearchResult(data: [], length: 0, page: 1, total: 0);
    if (tab == 'fuzzy') {
      result =
          fuzzySearch(keyword: keyword, length: 200, page: 1, data: dataList);
    } else if (tab == 'exact') {
      result =
          exactSearch(keyword: keyword, length: 200, page: 1, data: dataList);
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(result.data[index].text),
            ),
            onTap: () {
              currentText.changeText(result.data[index].index);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Navigator.defaultRouteName,
                (route) => false,
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: result.length);
  }
}
