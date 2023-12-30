import 'dart:developer';

import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:acim_helper/pages/search/search_utils.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({Key? key, required this.keyword, required this.tab})
      : super(key: key);

  final String keyword;
  final String tab;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    SearchResult result = SearchResult(data: [], length: 0, page: 1, total: 0);
    if (tab == 'fuzzy') {
      result =
          fuzzySearch(keyword: keyword, length: 200, page: 1, data: db.data);
    } else if (tab == 'exact') {
      result =
          exactSearch(keyword: keyword, length: 200, page: 1, data: db.data);
    }

    log('result length: ${result.data.length}');

    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: theme.searchViewTheme.backgroundColor,
            title: Padding(
              padding: const EdgeInsets.all(16),
              child: HighlightText(
                  text: result.data[index].text, keyword: keyword),
            ),
            onTap: () {
              drawItem.value = result.data[index];
              viewItem.value = result.data[index];
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
