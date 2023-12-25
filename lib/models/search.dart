import 'dart:core';

import 'package:acim_helper/models/data.dart';

class SearchResult {
  final int total;
  final int length;
  final int page;
  final List<DataItem> data;

  SearchResult(
      {required this.data,
      required this.length,
      required this.page,
      required this.total});
}

/// 分页
SearchResult toPageData({
  int length = 20,
  int page = 1,
  List<DataItem> items = const [],
}) {
  var total = items.length;
  var start = (page - 1) * length;
  var data = items.sublist(start, start + length).toList();

  return SearchResult(data: data, length: length, page: page, total: total);
}

/// 精确搜索
SearchResult exactSearch({
  String keyword = "",
  int length = 20,
  int page = 1,
  List<DataItem> data = const [],
}) {
  String temp = keyword.replaceAll(RegExp(r'[,，。;；？?!！|&【】”“ ]+'), " ");
  if (temp.isEmpty || temp.trim() == "") {
    return SearchResult(data: [], length: 0, page: 1, total: 0);
  }
  List<String> keywords = temp.split(" ");
  keywords = keywords.map((s) => s.replaceAll(RegExp(r'\.'), r'\.')).toList();
  List<DataItem> result = [...data];
  for (var word in keywords) {
    List<DataItem> arr = [];
    for (var item in result) {
      if (RegExp(word, caseSensitive: false).hasMatch(item.text)) {
        arr.add(item);
      }
    }
    result = arr;
  }

  return toPageData(items: result, page: page, length: length);
}

class SearchItem extends DataItem {
  final int count;
  late int weight;
  SearchItem(super.index, super.text,
      {required this.count, required this.weight});
}

/// 模糊搜索
SearchResult fuzzySearch({
  String keyword = "",
  int length = 20,
  int page = 1,
  List<DataItem> data = const [],
}) {
  List<String> keywords =
      keyword.replaceAll(RegExp(r'[,，。.\-;；？?！!"“” ]+'), "").split("");
  keywords = keywords.toSet().toList();
  List<SearchItem> result = [];

  for (var item in data) {
    int count = 0;
    for (int i = 0; i < keywords.length; i++) {
      if (item.text.contains(keywords[i])) {
        count += 1;
      }
    }
    if (count == 0) {
      continue;
    }

    result.add(SearchItem(item.index, item.text, count: count, weight: 0));
  }

  result.sort((a, b) => b.count - a.count);
  result.removeRange(200, result.length);

  RegExp reg = RegExp('[${keywords.join()}]+', caseSensitive: false);
  for (var item in result) {
    List<String>? arr =
        reg.allMatches(item.text).map((match) => match.group(0)!).toList();
    int weight = 1;
    for (var str in arr) {
      weight *= str.length;
    }
    item.weight = weight;
  }

  result.sort((a, b) {
    if (b.count == a.count) {
      return b.weight - a.weight;
    }
    return b.count - a.count;
  });

  return toPageData(length: length, page: page, items: result);
}
