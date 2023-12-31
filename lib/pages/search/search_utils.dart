import 'dart:core';
import 'dart:math';

import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';

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

SearchResult defaultResult =
    SearchResult(data: [], length: 0, page: 1, total: 0);

/// 分页
SearchResult toPageData({
  int length = 20,
  int page = 1,
  List<DataItem> items = const [],
}) {
  if (items.isEmpty) {
    return defaultResult;
  }
  var total = items.length;
  var start = (page - 1) * length;
  var data = items.sublist(start, min(start + length, items.length)).toList();
  return SearchResult(data: data, length: length, page: page, total: total);
}

/// 精确搜索
SearchResult exactSearch({
  String keyword = "",
  int length = 20,
  int page = 1,
  List<DataItem> data = const [],
}) {
  if (keyword.trim() == "") {
    return defaultResult;
  }
  List<String> keywords = keyword.split(" ").map((e) => e.trim()).toList();
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
  SearchItem(super.index, super.text, super.id,
      {required this.count, required this.weight});
}

/// 模糊搜索
SearchResult fuzzySearch({
  String keyword = "",
  int length = 20,
  int page = 1,
  List<DataItem> data = const [],
}) {
  List<String> keywords = keyword.split("").map((e) => e.trim()).toList();
  keywords = keywords.toSet().toList();
  List<SearchItem> result = [];

  if (keywords.isEmpty) {
    return SearchResult(data: [], length: 0, page: 1, total: 0);
  }

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

    result.add(
        SearchItem(item.index, item.text, item.id, count: count, weight: 0));
  }

  if (result.isEmpty) {
    return defaultResult;
  }

  result.sort((a, b) => b.count - a.count);
  if (result.length > 200) {
    result.removeRange(200, result.length);
  }

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

class HighlightText extends StatelessWidget {
  const HighlightText(
      {Key? key, required this.text, required this.keyword, required this.type})
      : super(key: key);

  final String text;
  final String keyword;
  final String type;

  List<TextSpan> buildSpansByReg(RegExp reg, TextStyle highlightStyle) {
    List<TextSpan> spans = [];
    final matches = reg.allMatches(text);
    for (var i = 0; i < matches.length; i++) {
      var match = matches.toList()[i];

      var lastEnd = i == 0 ? 0 : matches.toList()[i - 1].end;
      if (lastEnd != match.start) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
        ));
      }

      spans.add(
        TextSpan(
            text: text.substring(match.start, match.end),
            style: highlightStyle),
      );
    }
    spans.add(TextSpan(
      text: text.substring(matches.last.end),
    ));
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final highlightStyle = TextStyle(
      color: theme.colorScheme.onPrimaryContainer,
      backgroundColor: theme.colorScheme.primaryContainer,
    );

    List<TextSpan> spans = [];

    if (type == 'exact') {
      List<String> keywords = keyword.split(' ').map((e) => e.trim()).toList();
      RegExp reg = RegExp('(${keywords.join('|')})+', caseSensitive: false);
      spans = buildSpansByReg(reg, highlightStyle);
    }

    if (type == 'fuzzy') {
      RegExp reg =
          RegExp('[${keyword.replaceAll(' ', '')}]+', caseSensitive: false);
      spans = buildSpansByReg(reg, highlightStyle);
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: theme.colorScheme.onSurface),
      ),
    );
  }
}
